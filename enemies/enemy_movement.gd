extends Node2D

class_name EnemyMovement

@export  var target: Vector2
@export  var movement_per_sec: float = 25
@onready var parent_character_2d: CharacterBody2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	target = Vector2(0, 0)
	#target = Vector2(randf() * 200, randf() * 200)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var position: Vector2 = global_position
	var diff = target - position
	
	parent_character_2d.velocity = diff.normalized() * movement_per_sec
	var collision = parent_character_2d.move_and_collide(parent_character_2d.velocity * delta)
	if collision:
		parent_character_2d.velocity = parent_character_2d.velocity.slide(collision.get_normal())
	#parent_character_2d.move_and_collide(diff.normalized() * movement_per_sec * delta)
