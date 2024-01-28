extends Control
class_name GuiFade

@export var fade_in_duration: float = 1.0
@export var fade_out_duration: float = 1.0
signal finished_fade

func fade_in():
	var tween = create_tween()
	tween.tween_property(
		self, "modulate:a", 1, fade_in_duration
		)
	tween.tween_callback(_finish_fade)

func fade_out():
	var tween = create_tween()
	tween.tween_property(
		self, "modulate:a", 0, fade_out_duration
		)
	tween.tween_callback(_finish_fade)

func _finish_fade():
	finished_fade.emit()
