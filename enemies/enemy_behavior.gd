extends CharacterBody2D

class_name EnemyBehavior

@export var change_interval_miliseconds: float = 2000
@export var hit_effect_attributes: HitEffectAttributes

@onready var health_component: Health = $Health
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var movement: EnemyMovement = $EnemyMovement
@onready var state: Node = $Behaviors/FollowBehavior
@onready var hit_effect_player: HitEffectPlayer = $HitEffectPlayer
@onready var hurt_box: HurtBox = $HurtBox

var start_time := Time.get_ticks_msec()
var is_disabled: bool = false

signal on_death

func play_hit_effect():
	hit_effect_player.play_effect(hit_effect_attributes)

func _propagate_death(health: Health):
	on_death.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.connect("on_death", _propagate_death)
	movement.set_nav_agent(navigation_agent)
	hurt_box.connect("trigger", func(_damage): play_hit_effect())

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

