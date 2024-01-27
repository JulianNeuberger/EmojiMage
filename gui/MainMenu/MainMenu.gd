extends Node2D

func _ready():
	$CanvasLayer/CenterContainer/VBoxContainer/Start.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/testbed.tscn")

func _on_exit_pressed():
	get_tree().quit()
