extends Node2D

var game_saver: GameSaver


func _ready():
	game_saver = get_node("/root/GameSaver")
	if game_saver and game_saver.has_save():
		game_saver.load_game()
	fade_scene_in()

func fade_scene_out():
	var gui_fade = $CanvasLayer/GuiFade
	print(gui_fade)
	if gui_fade:
		gui_fade.fade_in()
		await gui_fade.finished_fade

func fade_scene_in():
	var gui_fade = $CanvasLayer/GuiFade
	print(gui_fade)
	if gui_fade:
		gui_fade.modulate.a = 1
		gui_fade.fade_out()
		await gui_fade.finished_fade
