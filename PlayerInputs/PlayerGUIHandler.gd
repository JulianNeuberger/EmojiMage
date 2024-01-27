extends Node
class_name PlayerGUIHandler

signal on_exit
#signal 

func _process(delta):
	var exit_pressed = Input.is_action_just_pressed("Exit")
	if exit_pressed:
		self.on_exit.emit()
	
