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
	
