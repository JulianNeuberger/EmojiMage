extends ProgressBar


func _ready():
	set_percentage(100)
	
	
func set_percentage(value: int):
	self.value = value
	visible = value != 100
