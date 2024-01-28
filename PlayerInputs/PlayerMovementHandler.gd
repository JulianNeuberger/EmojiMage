extends Node2D
class_name PlayerMovementHandler

var target: CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = get_parent().find_child("AnimatedSprite2D")
@export var step_interval_seconds: float = 1
@export var step_effect: HitEffectAttributes

var _effect_player: PackedScene = preload("res://HitEffects/effect_player.tscn")

var _last_step = -INF


func _ready():
	target = get_parent()


func _process(delta):
	target.velocity = Input.get_vector("Left", "Right", "Top", "Bottom")
	
	var now_seconds = Time.get_ticks_msec() / 1000.0
	var is_running = target.velocity.length_squared() > 0
	
	if is_running:
		animated_sprite.speed_scale = 1.0
	else:
		animated_sprite.speed_scale = 0.2
	
	var should_step = now_seconds >= _last_step + step_interval_seconds
	if is_running and should_step:
		_last_step = now_seconds
		_play_effect(step_effect)

func _play_effect(effect: HitEffectAttributes):
	var tree = get_tree()
	if tree == null: 
		# level already finished
		return
	var player: HitEffectPlayer = _effect_player.instantiate()
	tree.root.add_child(player)
	player.global_position = global_position
	player.global_rotation = global_rotation
	player.play(effect, self)
