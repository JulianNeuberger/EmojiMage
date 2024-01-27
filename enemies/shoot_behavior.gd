extends Node

class_name ShootBehavior

@export var target: Node2D
@export var movement: EnemyMovement
@export var shooting_distance: float = 300

@export var bullet_spawner: Node

var classname: String = "shoot"
	
func _process(delta):
	if target == null: 
		return
		
	if bullet_spawner == null:
		return
	
	bullet_spawner.trigger_bullet_spawn()

func can_make_transition(current_state):
	if target == null:
		return false
		
	if shooting_distance >= (target.global_position - movement.global_position).length():
		return true
	return false