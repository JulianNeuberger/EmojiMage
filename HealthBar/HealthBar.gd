extends ProgressBar


func _ready():
	set_percentage(100)
	
	
func set_percentage(value: int):
	self.value = value
	if value == 100 or value == 0:
		visible = false
	else:
		visible = true
	
