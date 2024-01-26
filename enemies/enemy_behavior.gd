extends CharacterBody2D

class_name EnemyBehavior

@onready var health_component: Health = $Health

# Called when the node enters the scene tree for the first time.
func _ready():
	$HurtBox.connect("trigger", func(source: HitBox): health_component.damage(10))
	health_component.connect("on_death", func(): print('You died!'))
