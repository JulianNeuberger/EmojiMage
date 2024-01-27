extends Resource
class_name Inventory

@export var slots: Array[Resource]
@export var max_slots: int = 3

signal slot_changed(active_slot: int)
signal inventory_changed(inventory: Inventory)

var active_slot: int = 0

func init():
	var missing_slots = max_slots - len(slots)
	for _i in range(max(0, missing_slots)):
		slots.push_back(null)
	inventory_changed.emit(self)

func add_to_inventory(weapon_behavior: Resource):
	# currently we have a  infinitely large inventory?
	slots.push_back(weapon_behavior)
	inventory_changed.emit(self)

func select_slot(slot_index: int):
	if slot_index < 0:
		printerr("Trying to set inventory slot with index < 0")
		return 
	if slot_index > len(slots):
		printerr("Trying to set inventory slot with index %d, which is greater than the number of slots (%d)" % [slot_index, len(slots)])
		return
	active_slot = slot_index
	slot_changed.emit(active_slot)
