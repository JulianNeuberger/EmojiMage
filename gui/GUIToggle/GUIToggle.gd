extends Control

@export var is_open = false
signal toggle(value)

func _ready():
	if is_open:
		open()
	else:
		close()

func open():
	is_open = true
	for child in get_children():
		child.visible = true
		if child.has_method("grab_gui_focus"):
			child.grab_gui_focus()
	toggle.emit(true)

func close():
	is_open = false
	for child in get_children():
		child.visible = false
	toggle.emit(false)

func toggle_gui():
	is_open = !is_open
	if is_open:
		open()
	else:
		close()
