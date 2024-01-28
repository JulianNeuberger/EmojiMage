extends CharacterBody2D
class_name Wizard

@export var movement_parameters: MovementResource
@export var inventory: Inventory
@export var hit_effect: HitEffectAttributes

@onready var health = $Health
@onready var hurt_box = $HurtBox

var effect_player: PackedScene = preload("res://HitEffects/effect_player.tscn")

func _ready():
	inventory.init()
	$PlayerInventoryHandler.connect("inventory_left", inventory.scroll_slot_left)
	$PlayerInventoryHandler.connect("inventory_right", inventory.scroll_slot_right)
	inventory.connect("slot_changed", func(_slot_index, slot_value): set_wand(slot_value))
	hurt_box.trigger.connect(func(_d, dir): _play_effect(hit_effect, dir))
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

func _play_effect(effect: HitEffectAttributes, hit_direction: Vector2):
	var tree = get_tree()
	if tree == null: 
		# level already finished
		return
	var player: HitEffectPlayer = effect_player.instantiate()
	tree.root.add_child(player)
	player.global_position = global_position
	player.global_rotation = Vector2.RIGHT.angle_to(hit_direction)
	player.play(effect, self)

