extends Area2D
class_name HurtBox

signal trigger(damage: float, hit_dir: Vector2)


func _on_area_entered(area):
	var source: HitBox = area
	var hit_dir = global_position - source.global_position
	var damage = source.on_hit.call()
	if damage is float:
		trigger.emit(damage, hit_dir.normalized())
