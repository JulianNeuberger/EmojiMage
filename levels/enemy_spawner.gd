extends Node2D
class_name EnemySpawner


@export var enemy_spawns: Array[EnemySpawn]
@export var radius: float = 150

func _ready():
	spawn_enemies()

func spawn_enemies():
	for enemy_spawn in enemy_spawns:
		for i in range(enemy_spawn.amount):
			var enemy: EnemyBehavior = enemy_spawn.enemy.instantiate()
			enemy.global_position = random_global_spawn_point()
			enemy.connect("on_death", func(): enemy.queue_free())
			get_parent().add_child(enemy)
			await get_tree().create_timer(enemy_spawn.delay).timeout
	

func random_global_spawn_point():
	var pos = global_position
	pos += Vector2((randf() - .5) * 2.0, (randf() - .5) * 2.0) * radius
	return pos
