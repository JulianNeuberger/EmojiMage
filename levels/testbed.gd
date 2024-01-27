extends Node2D

var game_saver: GameSaver


func _ready():
	game_saver = get_node("/root/GameSaver")
	if game_saver and game_saver.has_save():
		game_saver.load_game()
