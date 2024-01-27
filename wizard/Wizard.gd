extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@export var inventory: Inventory
@onready var health = $Health


func _ready():
	inventory.init()
	$PlayerInventoryHandler.connect("inventory_left", inventory.scroll_slot_left)
	$PlayerInventoryHandler.connect("inventory_right", inventory.scroll_slot_right)
	inventory.connect("slot_changed", func(_slot_index, slot_value): set_wand(slot_value))
	set_wand(inventory.slots[0])

func _process(delta):
	velocity *= movement_parameters.movement_speed
	move_and_slide()

func set_wand(wand_resource: WandResource):
	$Wand.set_wand_resorce(wand_resource)

func serialize() -> Dictionary:
	var dict = {
		"inventory": inventory.serialize(),
		"health": health.serialize(),
	}
	return dict

func deserialize(dictionary: Dictionary):
	if "inventory" in dictionary:
		inventory.deserialize(dictionary["inventory"])
	if "health" in dictionary:
		health.deserialize(dictionary["health"])
	
