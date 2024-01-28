extends Area2D
class_name HitBox
signal trigger(target: HurtBox)
@export var on_hit: Callable

func _on_area_entered(area):
	var source: HurtBox = area
	var dir = global_position - source.global_position
	trigger.emit(source, dir.normalized())
