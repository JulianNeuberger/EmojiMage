extends Node2D

@export var min_radius = 0.9
@export var max_radius = 1.1
@export var min_duration = 0.2
@export var max_duration = 0.3

var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.timeout.connect(start_tween)
	start_tween()


func start_tween():
	var rand_scale = randf_range(min_radius, max_radius)
	
	var rand_duration = randf_range(min_duration, max_duration)
	change_light_radius(rand_scale, rand_duration)
	timer.start(rand_duration)


func change_light_radius(scale: float, duration: float):
	var tween = create_tween()
	tween.tween_property($ShadowLight, "texture_scale", scale, duration)
	tween.tween_property($AmbientLight, "texture_scale", scale, duration)
	tween.tween_property($AmbientLight, "energy", 0.5 * scale / 4, duration)
