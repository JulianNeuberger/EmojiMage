extends Node2D

var game_saver: GameSaver


func _ready():
	fade_scene_in()
	$CanvasLayer/CenterContainer/Ok.grab_focus()
	game_saver = get_node("/root/GameSaver")
	if game_saver:
		var level_name = game_saver.get_level_name()
		if level_name == "null":
			$CanvasLayer/CenterContainer/Chars/PrincessAnimation/Intro.visible = 1
			$CanvasLayer/CenterContainer/Chars/MageAnimation/Level1.visible = 0
		else:
			$CanvasLayer/CenterContainer/Chars/PrincessAnimation/Intro.visible = 0
			$CanvasLayer/CenterContainer/Chars/MageAnimation/Level1.visible = 1
		



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
