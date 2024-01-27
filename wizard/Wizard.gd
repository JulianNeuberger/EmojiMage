extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@export var inventory: Inventory
@onready var health = $Health


func _ready():
	inventory.init()
	$PlayerInventoryHandler.connect("inventory_left", inventory.scroll_slot_left)
	$PlayerInventoryHandler.connect("inventory_right", inventory.scroll_slot_right)
	inventory.connect("slot_changed", func(_slot_index, slot_value): $Wand.set_wand_resorce(slot_value))

func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()

func serialize() -> Dictionary:
	var dict = {
		"inventory": inventory.serialize(),
		"health": health.serialize(),
	}
	print(dict)
	return dict

func deserialize(dictionary: Dictionary):
	print(dictionary)
	if "inventory" in dictionary:
		inventory.deserialize(dictionary["inventory"])
	if "health" in dictionary:
		health.deserialize(dictionary["health"])
	
