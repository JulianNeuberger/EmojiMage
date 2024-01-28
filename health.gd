extends Node

class_name Health

signal on_death(health_component: Health)
signal percentage_changed(health_percentage: int)
@export var max_health: float = 100.0
@export var current_health: float

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	update_percentage()


func receive_hurt_box_damage(damage_amount: float, _direction: Vector2):
	damage(damage_amount)

func damage(damage_amount: float):
	current_health -= damage_amount
	update_percentage()
	if current_health <= 0.0:
		on_death.emit(self)


func update_percentage():
	var current_percentage = int(round((current_health / max_health) * 100))
	percentage_changed.emit(current_percentage)

func serialize() -> Dictionary:
	return {
		"current_health": current_health
	}

func deserialize(resource: Dictionary):
	current_health = resource["current_health"]
	update_percentage()
