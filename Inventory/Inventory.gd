extends Node
class_name Inventory

@export var slots: Array[Resource]

signal slot_changed(active_slot: int)
signal inventory_changed(inventory: Inventory)

var _active_slot: int

func add_to_inventory(weapon_behavior: Resource):
	# currently we have a  infinitely large inventory?
	slots.push_back(weapon_behavior)

func select_slot(slot_index: int):
	if slot_index < 0:
		printerr("Trying to set inventory slot with index < 0")
		return 
	if slot_index > len(slots):
		printerr("Trying to set inventory slot with index %d, which is greater than the number of slots (%d)" % [slot_index, len(slots)])
		return
	_active_slot = slot_index
	slot_changed.emit(_active_slot)
