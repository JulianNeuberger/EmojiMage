extends Node2D
signal inventory_left
signal inventory_right


func _process(delta):
	if Input.is_action_just_pressed("inventory_left"):
		inventory_left.emit()
	if Input.is_action_just_pressed("inventory_right"):
		inventory_right.emit()
