extends Node2D

@export var game_over_scene: PackedScene
var wizard: Wizard

func _ready():
	wizard = get_tree().get_first_node_in_group("player")
	wizard.health.on_death.connect(change_scene)

func change_scene(health: Health):
	get_tree().change_scene_to_packed(game_over_scene)
