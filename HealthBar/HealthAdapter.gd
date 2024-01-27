extends Node
class_name HealthAdapter


@export var health_bar: HealthBar
var health: Health

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	health = player.health
	health.percentage_changed.connect(health_bar.set_percentage)
