extends Area2D
class_name HitBox
signal trigger(target: HurtBox)


func _on_area_entered(area):
	var source: HurtBox = area	
	trigger.emit(source)
