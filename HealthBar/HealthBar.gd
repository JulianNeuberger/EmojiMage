extends ProgressBar
class_name HealthBar

@export var can_turn_invisible = true

func _ready():
	set_percentage(value)
	
	
func set_percentage(value: int):
	self.value = value
	if can_turn_invisible and (value == 100 or value == 0):
		visible = false
	else:
		visible = true
	
