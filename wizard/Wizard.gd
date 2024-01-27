extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@export var inventory: Inventory

func _ready():
	inventory.init()

func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()
