extends Node2D

var game_saver: GameSaver


func _ready():
	game_saver = get_node("/root/GameSaver")
	if game_saver:
		game_saver.load_game()
