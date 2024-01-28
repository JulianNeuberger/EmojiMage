extends Node2D
class_name EnemySpawner


signal on_all_spawned
signal on_all_killed

@export var enemy_spawns: Array[EnemySpawn]
@export var radius: float = 150

var _all_spawned: bool = false
var _num_alive: int = 0
var _end_timeout_seconds = 1.
var _ended = false


func _ready():
	spawn_enemies()


func _process(delta):
	if _ended:
		return
	if _num_alive == 0:
		_end_timeout_seconds -= delta
	if _end_timeout_seconds <= 0:
		_ended = true
		end()

func end():
	await get_parent().fade_scene_out()
	on_all_killed.emit()


func kill_enemy(enemy: EnemyBehavior):
	enemy.queue_free()
	_num_alive -= 1


func spawn_enemies():
	var player = get_tree().get_nodes_in_group("player")[0]
	for enemy_spawn in enemy_spawns:
		for i in range(enemy_spawn.amount):
			var enemy: EnemyBehavior = enemy_spawn.enemy.instantiate()
			enemy.global_position = random_global_spawn_point()
			enemy.connect("on_death", func(): kill_enemy(enemy))
			enemy.set_target(player)
			get_parent().add_child.call_deferred(enemy)
			_num_alive += 1
			await get_tree().create_timer(enemy_spawn.delay).timeout
	_all_spawned = true
	on_all_spawned.emit()
	

func random_global_spawn_point():
	var pos = global_position
	pos += Vector2((randf() - .5) * 2.0, (randf() - .5) * 2.0) * radius
	return pos
