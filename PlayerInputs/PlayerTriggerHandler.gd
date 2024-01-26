extends Node2D
signal trigger
@export var triggers_per_second: int = 1
var delay_time: float
var waiting_timer: Timer
var can_shoot = true

func _ready():
	waiting_timer = Timer.new()
	add_child(waiting_timer)
	waiting_timer.autostart = false
	waiting_timer.timeout.connect(_on_timeout)
	delay_time = 1.0 / triggers_per_second

func _process(delta):
	if can_shoot and Input.is_action_pressed("Trigger"):
		trigger.emit()
		waiting_timer.start(delay_time)
		can_shoot = false

func _on_timeout():
	can_shoot = true
