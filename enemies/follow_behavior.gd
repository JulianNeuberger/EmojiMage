extends Node

class_name FollowBehavior

@export var target: Node2D
@export var movement: EnemyMovement
var classname: String = "follow"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target == null:
		return
	var tar_position = target.global_position
	movement.set_target(tar_position)

func can_make_transition(current_state):
	return true
