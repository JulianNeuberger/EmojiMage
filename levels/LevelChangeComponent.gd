extends Node2D

@export var next_scene: PackedScene
var game_saver: GameSaver

func _ready():
	game_saver = get_node("/root/GameSaver")

func change_scene():
	if game_saver:
		game_saver.save_game()
	get_tree().change_scene_to_packed(next_scene)
