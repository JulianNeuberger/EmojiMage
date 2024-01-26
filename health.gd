extends Node

class_name Health

signal on_death(health_component: Health)
var max_health: float = 100.0
var current_health: float

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health

func damage(damage_amount: float):
	current_health -= damage_amount
	
	if current_health == 0.0:
		on_death.emit(self)
