extends Resource
class_name Inventory

@export var slots: Array[WandResource] = []
@export var max_slots: int = 3

signal slot_changed(active_slot: int, slot_value: WandResource)
signal inventory_changed(inventory: Inventory)

var active_slot: int = 0

func init():
	var missing_slots = max_slots - len(slots)
	for _i in range(max(0, missing_slots)):
		slots.push_back(null)
	inventory_changed.emit(self)

func add_to_inventory(weapon_behavior: WandResource):
	for i in range(len(slots)):
		if slots[i] == null:
			add_to_index(weapon_behavior, i)
			return
	# currently we have a  infinitely large inventory?
	slots.push_back(weapon_behavior)
	inventory_changed.emit(self)

func add_to_index(weapon_behaviour: WandResource, index: int):
	slots[index] = weapon_behaviour
	inventory_changed.emit(self)

func scroll_slot_left():
	select_slot((active_slot + len(slots) - 1) % len(slots))
	
func scroll_slot_right():
	select_slot((active_slot + 1) % len(slots))

func select_slot(slot_index: int):
	if slot_index < 0:
		printerr("Trying to set inventory slot with index < 0")
		return 
	if slot_index > len(slots):
		printerr("Trying to set inventory slot with index %d, which is greater than the number of slots (%d)" % [slot_index, len(slots)])
		return
	active_slot = slot_index
	slot_changed.emit(active_slot, slots[active_slot])

func serialize() -> Dictionary:
	return {
		"slots": slots.map(save_wand_resource)
	}

func deserialize(dict: Dictionary):
	var resource_slots = dict["slots"]
	slots = []
	for wand_name in resource_slots:
		if wand_name == "null":
			add_to_inventory(null)
		else:
			var wand_resource = load("res://Wand/%s.tres" % wand_name)
			add_to_inventory(wand_resource)
	
func save_wand_resource(wand_resource):
	if wand_resource:
		return wand_resource.name
	else:
		return "null"
