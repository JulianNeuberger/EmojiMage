extends CharacterBody2D

class_name EnemyBehavior

@onready var health_component: Health = $Health

signal on_death

func _propagate_death(health: Health):
	print('You died!')
	on_death.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	$HurtBox.connect("trigger", func(source: HitBox): health_component.damage(10))
	health_component.connect("on_death", _propagate_death)

func set_target(target: Node2D):
	for child in $Behaviors.get_children():
		child.target = target
