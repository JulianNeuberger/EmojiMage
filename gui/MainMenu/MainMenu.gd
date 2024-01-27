extends Node2D

var game_saver: GameSaver

func _ready():
	var continue_button = $CanvasLayer/CenterContainer/VBoxContainer/Continue
	var start_button = $CanvasLayer/CenterContainer/VBoxContainer/Start 
	game_saver = get_node("/root/GameSaver")
	if game_saver.has_save():
		continue_button.visible = true
		continue_button.grab_focus()
	else:
		continue_button.visible = false
		start_button.grab_focus()
	

func _on_start_pressed():
	game_saver.delete_game()
	get_tree().change_scene_to_file("res://levels/testbed.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://levels/testbed.tscn")
