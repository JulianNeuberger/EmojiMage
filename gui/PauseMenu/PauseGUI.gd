extends Control
class_name PauseGUI

signal close_gui
var game_saver: GameSaver

func _ready():
	game_saver = get_node("/root/GameSaver")

func _on_continue_pressed():
	close_gui.emit()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://gui/MainMenu/MainMenu.tscn")

func grab_gui_focus():	
	$VBoxContainer/Continue.grab_focus()


func _on_save_pressed():
	if game_saver:
		game_saver.save_game()
