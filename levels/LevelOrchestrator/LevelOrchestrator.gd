extends Node

var game_saver: GameSaver


func _ready():
	game_saver = get_node("/root/GameSaver")


func load_level():
	var level_name = game_saver.get_level_name()
	change_level_to(level_name)


func change_level_to(level_name: String):
	match(level_name):
		"Level1":
			get_tree().change_scene_to_file("res://levels/Level1/Level1.tscn")
		"Level2":
			get_tree().change_scene_to_file("res://levels/Level2/Level2.tscn")
		"Level3":
			get_tree().change_scene_to_file("res://levels/Level3/Level3.tscn")
		"Level4":
			get_tree().change_scene_to_file("res://levels/Level4/Level4.tscn")
		"Level5":
			get_tree().change_scene_to_file("res://levels/Level5/Level5.tscn")
