extends Node

var game_saver: GameSaver


func _ready():
	game_saver = get_node("/root/GameSaver")


func load_level():
	var level_name = game_saver.get_level_name()
	var completed = game_saver.get_level_completed()
	get_parent().fade_scene_out()
	change_level_to(level_name, completed)


func change_level_to(level_name: String, completed: bool):
	if level_name == "null":
		level_name = "Level1"
	if completed:
		level_name = get_next_level_name(level_name)
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

func get_next_level_name(level_name: String) -> String:
	match level_name:
		"Level1":
			return "Level2" 
		"Level2":
			return "Level3"
		"Level3":
			return "Level4"
		"Level4":
			return "Level5"
	return level_name
