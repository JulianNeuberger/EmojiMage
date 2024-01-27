extends Node2D

class_name EnemyMovement

@export  var movement_per_sec: float = 25
@onready var parent_character_2d: CharacterBody2D = get_parent()

var _nav_agent: NavigationAgent2D = null


func _physics_process(delta):
	if _nav_agent == null:
		return
	
	var position: Vector2 = global_position
	var next_position: Vector2 = _nav_agent.get_next_path_position()
	
	var diff = next_position - position
	var velocity = diff.normalized() * movement_per_sec

	parent_character_2d.velocity = velocity * movement_per_sec
	var collision = parent_character_2d.move_and_collide(parent_character_2d.velocity * delta)
	if collision:
		parent_character_2d.velocity = parent_character_2d.velocity.slide(collision.get_normal())

func set_nav_agent(nav_agent: NavigationAgent2D):
	_nav_agent = nav_agent

func set_target(target: Vector2):
	if _nav_agent == null: 
		return
	_nav_agent.target_position = target
