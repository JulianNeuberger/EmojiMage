extends Area2D
class_name HurtBox

signal trigger(source: HitBox)


func _on_area_entered(area):
	var source: HitBox = area	
	trigger.emit(source)
