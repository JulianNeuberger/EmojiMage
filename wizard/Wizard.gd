extends CharacterBody2D

@export var movement_parameters: MovementResource

func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()
