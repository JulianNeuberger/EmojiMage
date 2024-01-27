extends Control
class_name InventorySlotView

@onready var inactive_background_sprite: TextureRect = $Background
@onready var active_background_sprite: TextureRect = $BackgroundActive
@onready var weapon_sprite: TextureRect = $Item

func set_weapon(weapon: Resource):
	if weapon == null:
		weapon_sprite.texture = null
		return

func set_active(active: bool):
	inactive_background_sprite.visible = not active
	active_background_sprite.visible = active
