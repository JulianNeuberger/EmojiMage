extends Node

class_name KeepDistanceBehavior

@export var target: Node2D
@export var movement: EnemyMovement
@export var keep_distance: float = 250
var classname: String = "keep_distance"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	
	var target_position = target.global_position
	 
	var diff = target_position - movement.global_position
	
	movement.set_target(target_position - diff.normalized() * keep_distance)

func can_make_transition(current_state):
	if target == null:
		return false
		
	if keep_distance >= (target.global_position - movement.global_position).length():
		return true
	return false
