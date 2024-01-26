extends Node2D
class_name PlayerRotationHandler

var target: Node2D

func _ready():
	target = get_parent()

func _process(delta):
	var controller_rotation = _handle_controller_input()
	var mouse_rotation = _handle_mouse_input()
	var rotation = controller_rotation
	if controller_rotation == Vector2.ZERO:
		rotation = mouse_rotation
	target.look_at(target.position + rotation)

func _handle_controller_input() -> Vector2:
	return Input.get_vector("LookLeft", "LookRight", "LookUp", "LookBottom")
	
func _handle_mouse_input() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - target.global_position
	return direction.normalized()
