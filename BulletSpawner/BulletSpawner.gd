extends Node2D
var bullet_prototype = preload("res://bullet/Bullet.tscn")
@export var bullet_resource: BulletResource
@export var bullet_spread: float = 0.1
@export var bullets_per_shot: int
@export var bullet_speed_variance: int = 2
@export var shots_per_second: int

var delay_time: float
var waiting_timer: Timer
var can_shoot = true
var rng = RandomNumberGenerator.new()


func _ready():
	waiting_timer = Timer.new()
	add_child(waiting_timer)
	waiting_timer.autostart = false
	waiting_timer.timeout.connect(_on_timeout)
	
	
func generate_delay_time():
	delay_time = 1.0 / shots_per_second


func _on_timeout():
	can_shoot = true
	
	
func trigger_bullet_spawn():
	if can_shoot:
		spawn_bullet()
		waiting_timer.start(delay_time)
		can_shoot = false


func spawn_bullet():
	for i in range(bullets_per_shot):
		var node: Bullet = bullet_prototype.instantiate()
		if "Enemy" in get_groups():
			node.set_layer("EnemyHitBox", true)
		else:
			node.set_layer("HitBox", true)
				
		node.set_bullet_speed(bullet_resource.speed + rng.randf_range(-bullet_speed_variance, bullet_speed_variance))
		node.set_bullet_resource(bullet_resource)
		var spread = rng.randf_range(-bullet_spread, bullet_spread)
		node.set_start_direction(Vector2(1,0).rotated(global_rotation + spread))
		node.global_position = global_position
		var root = get_tree().root
		root.add_child(node)
