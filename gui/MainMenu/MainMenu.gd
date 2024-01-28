extends Node2D

var game_saver: GameSaver
var continue_button
var start_button

func _ready():
	continue_button = $CanvasLayer/CenterContainer/VBoxContainer/Continue
	start_button = $CanvasLayer/CenterContainer/VBoxContainer/Start 
	game_saver = get_node("/root/GameSaver")
	grab_gui_focus()
	_fade_scene_in()

func _on_start_pressed():
	_fade_scene_out()
	game_saver.delete_game()
	get_tree().change_scene_to_file("res://levels/Level1/Level1.tscn")

func _on_exit_pressed():
	_fade_scene_out()
	get_tree().quit()

func _on_continue_pressed():
	_fade_scene_out()
	get_tree().change_scene_to_file("res://levels/Level1/Level1.tscn")

func grab_gui_focus():
	if game_saver:
		if game_saver.has_save():
			continue_button.visible = true
			continue_button.grab_focus()
		else:
			continue_button.visible = false
			start_button.grab_focus()

func _on_gui_toggle_toggle(value):
	if !value:
		grab_gui_focus()

func _fade_scene_out():
	var gui_fade = $CanvasLayer/GuiFade
	if gui_fade:
		gui_fade.fade_in()
		await gui_fade.finished_fade

func _fade_scene_in():
	var gui_fade = $CanvasLayer/GuiFade
	if gui_fade:
		gui_fade.modulate.a = 1
		gui_fade.fade_out()
		await gui_fade.finished_fade
