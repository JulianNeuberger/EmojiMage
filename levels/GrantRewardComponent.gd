extends Node2D
class_name GrantRewardComponent

@export var wand_reward: WandResource
var target_to_grant

func _ready():
	target_to_grant = get_tree().get_nodes_in_group("player")[0]

func grant_reward():
	if target_to_grant and wand_reward:
		target_to_grant.inventory.add_to_inventory(wand_reward)
