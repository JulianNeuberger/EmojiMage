extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@export var inventory: Inventory

func _ready():
	inventory.init()
	$PlayerInventoryHandler.connect("inventory_left", inventory.scroll_slot_left)
	$PlayerInventoryHandler.connect("inventory_right", inventory.scroll_slot_right)

func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()
