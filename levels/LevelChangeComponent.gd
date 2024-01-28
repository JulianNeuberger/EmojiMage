extends Node2D

@export var next_scene: PackedScene
@export var next_level_name: String
var game_saver: GameSaver

func _ready():
	game_saver = get_node("/root/GameSaver")

func change_scene():
	get_parent().level_completed = true
	if game_saver:
		game_saver.save_game()
	get_parent().fade_scene_out()
	get_tree().change_scene_to_packed(next_scene)
