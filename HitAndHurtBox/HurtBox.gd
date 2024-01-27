extends Area2D
class_name HurtBox

signal trigger(source: HitBox)


func _on_area_entered(area):
	var source: HitBox = area
	
	for group in source.get_groups():
		if group in get_groups():
			return
	
	trigger.emit(source)
