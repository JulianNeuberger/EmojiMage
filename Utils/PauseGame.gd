extends Node
class_name PauseGame

func set_pause(value: bool):
	if value:
		resume()
	else:
		pause()


func pause():
	var game_timers = get_tree().get_nodes_in_group("game_timer")
	for timer in game_timers:
		timer.paused = true


func resume():
	var game_timers = get_tree().get_nodes_in_group("game_timer")
	for timer in game_timers:
		timer.paused = false
