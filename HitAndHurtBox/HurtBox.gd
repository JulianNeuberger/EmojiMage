extends Area2D
class_name HurtBox

signal trigger(damage: float)


func _on_area_entered(area):
	var source: HitBox = area
	var damage = source.on_hit.call()
	if damage is float:
		trigger.emit(damage)
