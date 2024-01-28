extends Control

@export var emoji_texture = Texture2D
@export var min_radius = 0.9
@export var max_radius = 1.1
@export var duration = 0.2
@export var offset = 10

var initial_scale: Vector2
var timer: Timer
var growing = false
var start_pos_y: float

func _ready():
	$Emoji.texture = emoji_texture
	start_pos_y = position.y
	initial_scale = scale
	timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.timeout.connect(start_tween)
	start_tween()


func start_tween():
	var target_radius = initial_scale
	var target_offset = 0
	if growing:
		target_offset = offset
		target_radius *= min_radius
	else:
		target_offset = 0
		target_radius *= max_radius
	growing = !growing
	change_light_radius(target_radius, target_offset, duration)
	timer.start(duration)


func change_light_radius(scale: Vector2, offset: float, duration: float):
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Gradient, "scale", scale, duration)
	tween.tween_property(self, "position:y", start_pos_y + offset, duration)
