extends Node2D

class_name EnemyMovement

@export  var movement_per_sec: float = 25
@onready var parent_character_2d: CharacterBody2D = get_parent()

var _nav_agent: NavigationAgent2D = null
var _movement_delta: float


func _physics_process(delta):
	if _nav_agent == null:
		return
	
	var position: Vector2 = global_position
	var next_position: Vector2 = _nav_agent.get_next_path_position()
	
	var diff = next_position - position
	var velocity = diff.normalized() * movement_per_sec
	
	_movement_delta = delta

	var new_velocity = velocity * movement_per_sec
	if _nav_agent.avoidance_enabled:
		_nav_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func set_nav_agent(nav_agent: NavigationAgent2D):
	_nav_agent = nav_agent
	if _nav_agent == null:
		return
	_nav_agent.connect("velocity_computed", _on_velocity_computed)

func set_target(target: Vector2):
	if _nav_agent == null: 
		return
	_nav_agent.target_position = target
	
func _on_velocity_computed(safe_velocity: Vector2) -> void:
	parent_character_2d.velocity = safe_velocity# * _movement_delta
	var collision = parent_character_2d.move_and_slide()
	#if collision:
	#	parent_character_2d.velocity = parent_character_2d.velocity.slide(collision.get_normal())
	
	#global_position = parent_character_2d.global_position.move_toward(parent_character_2d.global_position + safe_velocity, _movement_delta)
