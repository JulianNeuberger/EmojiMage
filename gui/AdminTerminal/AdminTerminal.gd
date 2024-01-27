extends LineEdit

var LEVEL_SELECT = "Level="
func grab_gui_focus():
	grab_focus()


func _on_text_submitted(new_text: String):
	if new_text.begins_with(LEVEL_SELECT):
		change_level_to(new_text.erase(0, len(LEVEL_SELECT)))

func change_level_to(name: String):
	match(name):
		"Level1":
			get_tree().change_scene_to_file("res://levels/Level1/Level1.tscn")
		"Level2":
			get_tree().change_scene_to_file("res://levels/Level2/Level2.tscn")
		"Level3":
			get_tree().change_scene_to_file("res://levels/Level3/Level3.tscn")
		"Level4":
			get_tree().change_scene_to_file("res://levels/Level4/Level4.tscn")
		"Level5":
			get_tree().change_scene_to_file("res://levels/Level5/Level5.tscn")
		
