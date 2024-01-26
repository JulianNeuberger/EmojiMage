extends Node2D
class_name PlayerMovementHandler

var target: CharacterBody2D



func _ready():
	target = get_parent()


func _process(delta):
	target.velocity = Input.get_vector("Left", "Right", "Top", "Bottom")
