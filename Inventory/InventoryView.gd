extends Control


@export var slot_view: PackedScene


func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	player.inventory.connect("inventory_changed", _update_with_inventory)
	_update_with_inventory(player.inventory)
	player.inventory.connect("slot_changed", func(slot_index, _slot): _set_active_slot(slot_index))
	_set_active_slot(player.inventory.active_slot)

func _update_with_inventory(inventory: Inventory):
	print("updating inventory with %d slots" % len(inventory.slots))
	for child in get_children():
		child.queue_free()
	for slot in inventory.slots:
		_add_slot_view(slot)

func _set_active_slot(slot_index: int):
	var index = 0
	for child in get_children():
		child.set_active(slot_index == index)
		index += 1

func _add_slot_view(slot: WandResource):
	var slot_instance = slot_view.instantiate()
	add_child(slot_instance)
	slot_instance.set_weapon(slot)
