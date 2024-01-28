extends CharacterBody2D
class_name Bullet

@export var damage: int = 1
@export var start_direction: Vector2
@export var bullet_resource: BulletResource
@onready var bullet_sprite: Sprite2D = $BulletSprite
var rng = RandomNumberGenerator.new()

func _ready():
	$HitBox.trigger.connect(on_bullet_hit)
	set_start_direction(start_direction)
	set_bullet_resource(bullet_resource)
	set_bullet_sprite()
	var timer = Timer.new()
	self.add_child(timer)
	timer.timeout.connect(queue_free)
	var timeout_variance = rng.randfn(-bullet_resource.time_to_life_variance, bullet_resource.time_to_life_variance)
	timer.set_wait_time(bullet_resource.time_to_life + timeout_variance)
	timer.start()

func get_damage() -> float:
	return bullet_resource.damage

func _process(delta):
	var collided = move_and_slide()
	if collided:
		queue_free()

func on_bullet_hit(target: HurtBox, _direction: Vector2):
	#animation
	queue_free()

func set_start_direction(start_direction: Vector2):
	self.start_direction = start_direction
	$ConstantVelocityComponent.direction = start_direction

func set_bullet_resource(bullet_resource:BulletResource):
	self.bullet_resource = bullet_resource
	$HitBox.on_hit = get_damage

func set_bullet_speed(speed: float):
	$ConstantVelocityComponent.speed = speed

func set_bullet_sprite():
	bullet_sprite.texture = bullet_resource.sprite
	bullet_sprite.rotation = randf_range(
		-bullet_resource.rotation_radians_variance, 
		bullet_resource.rotation_radians_variance
	)
	
func set_layer(name, value):
	var hitbox = $HitBox
	if name == "EnemyHitBox":
		hitbox.set_collision_layer_value(12, value)
		hitbox.set_collision_layer_value(10, !value)
		
		hitbox.set_collision_mask_value(9, value)
		hitbox.set_collision_mask_value(11, !value)
	else:
		hitbox.set_collision_layer_value(12, !value)
		hitbox.set_collision_layer_value(10, value)
		
		hitbox.set_collision_mask_value(11, value)
		hitbox.set_collision_mask_value(9, !value)
