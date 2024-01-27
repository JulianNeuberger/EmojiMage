extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@onready var health = $Health


func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()
