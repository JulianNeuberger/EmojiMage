extends Node

# see https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("saveable")
	for node in save_nodes:
		if !node.has_method("serialize"):
			continue
		var node_data = node.serialize()
		var json_string = JSON.stringify(node_data)
		save_game.store_line(json_string)


func load_save_file():
	if not FileAccess.file_exists("user://savegame.save"):
		return []
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	var save_data_list = []
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		json.parse(json_string)
		save_data_list.append(json.get_data())
	return save_data_list

func get_level_name() -> String:
	var save_file = load_save_file()
	for node_save in save_file:
		if "level_name" in node_save:
			return node_save["level_name"]
	return "null"
	
func get_level_completed() -> bool:
	var save_file = load_save_file()
	for node_save in save_file:
		if "level_completed" in node_save:
			return node_save["level_completed"]
	return false
	
	
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	var save_nodes = get_tree().get_nodes_in_group("saveable")
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		var node_data = json.get_data()
		for node in save_nodes:
			node.deserialize(node_data)
	
func delete_game():
	DirAccess.remove_absolute("user://savegame.save")

func has_save() -> bool:
	return FileAccess.file_exists("user://savegame.save")
