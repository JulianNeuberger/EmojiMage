extends Node2D

var game_saver: GameSaver
@export var level_name: String
var level_completed: bool

func _ready():
	game_saver = get_node("/root/GameSaver")
	if game_saver and game_saver.has_save():
		game_saver.load_game()


func serialize():
	var next_level_name = $LevelChangeComponent.next_level_name
	print("ney",next_level_name, level_completed)
	print("current", level_name)
	print("setValue ", next_level_name if level_completed else level_name)
	return {
		"level_name": next_level_name if level_completed else level_name
	}
	
	
func deserialize(data: Dictionary):
	print("load level", data)
	if "level_name" in data:
		var level_name = data["level_name"]
		print(level_name != self.level_name)
		if level_name != self.level_name:
			change_level_to(level_name)
	

func change_level_to(level_name: String):
	get_tree().change_scene_to_file("res://levels/Level2/Level2.tscn")
	"""
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
	"""
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
