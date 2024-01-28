extends Node2D


func _ready():
	fade_scene_in()
	$CanvasLayer/CenterContainer/Ok.grab_focus()



func fade_scene_out():
	var gui_fade = $CanvasLayer/GuiFade
	if gui_fade:
		gui_fade.fade_in()
		await gui_fade.finished_fade

func fade_scene_in():
	var gui_fade = $CanvasLayer/GuiFade
	if gui_fade:
		gui_fade.modulate.a = 1
		gui_fade.fade_out()
		await gui_fade.finished_fade
