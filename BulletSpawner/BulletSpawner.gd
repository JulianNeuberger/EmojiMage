extends Node2D
var bullet_prototype = preload("res://bullet/Bullet.tscn")
@export var bullet_resource: BulletResource


func spawn_bullet():
	var node: Bullet = bullet_prototype.instantiate()
	node.set_bullet_resource(bullet_resource)
	node.set_start_direction(Vector2(1,0).rotated(global_rotation))
	node.global_position = global_position
	var root = get_tree().root
	root.add_child(node)
