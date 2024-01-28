extends CharacterBody2D

class_name EnemyBehavior

@export var change_interval_miliseconds: float = 2000

var effect_player: PackedScene = preload("res://HitEffects/effect_player.tscn")

@export var hit_effect: HitEffectAttributes
@export var death_effect: HitEffectAttributes

@onready var health_component: Health = $Health
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var movement: EnemyMovement = $EnemyMovement
@onready var state: Node = $Behaviors/FollowBehavior
@onready var hurt_box: HurtBox = $HurtBox

var start_time := Time.get_ticks_msec()
var is_disabled: bool = false
var dead = false

signal on_death

func play_hit_effect(hit_direction: Vector2):
	_play_effect(hit_effect, hit_direction)

func play_death_effect(hit_direction: Vector2):
	_play_effect(death_effect, hit_direction)

func _play_effect(effect: HitEffectAttributes, hit_direction: Vector2):
	var tree = get_tree()
	if tree == null: 
		# level already finished
		return
	var player: HitEffectPlayer = effect_player.instantiate()
	tree.root.add_child(player)
	player.global_position = global_position
	player.global_rotation = Vector2.RIGHT.angle_to(hit_direction)
	player.play(effect, self)

func _propagate_death(health: Health):
	if !dead:
		on_death.emit()
		dead = true

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.connect("on_death", _propagate_death)
	movement.set_nav_agent(navigation_agent)
	hurt_box.connect("trigger", func(_damage, hit_direction): play_hit_effect(hit_direction))

func _process(delta):
	for child in $Behaviors.get_children():
		if child.can_make_transition(state):
			state = child
			child.set_process(true)
		else:
			child.set_process(false)
	
func set_target(target: Node2D):
	for child in $Behaviors.get_children():
		child.target = target
		if child is SmackBehavior:
			child.set_target(target)

