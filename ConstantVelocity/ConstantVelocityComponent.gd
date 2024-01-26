extends Node2D

@export var direction: Vector2 = Vector2.ZERO
@export var speed: float = 0.0
var target: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	target.velocity = direction * speed
