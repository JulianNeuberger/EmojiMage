extends Node
signal toggle_admin_panel
 

func _process(delta):
	var pressed = Input.is_action_just_pressed("AdminPanel")
	if pressed:
		self.toggle_admin_panel.emit()
	
