extends Node2D
class_name PlayerMovementHandler

var target: CharacterBody2D
@onready var step_particle_system: CPUParticles2D = get_parent().find_child("StepParticles")
@onready var animated_sprite: AnimatedSprite2D = get_parent().find_child("AnimatedSprite2D")
@export var step_interval_seconds: float = .5

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
	step_particle_system.emitting = false
	if is_running and should_step:
		_last_step = now_seconds
		step_particle_system.emitting = true
