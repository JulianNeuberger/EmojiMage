extends CharacterBody2D
class_name Bullet

@export var damage: int = 1
@export var start_direction: Vector2
@export var start_speed: float

func _ready():
	$HitBox.trigger.connect(on_bullet_hit)
	set_start_direction(start_direction)
	set_start_speed(start_speed)

func _process(delta):
	move_and_slide()

func on_bullet_hit(target: HurtBox):
	#animation
	queue_free()

func set_start_direction(start_direction: Vector2):
	self.start_direction = start_direction
	$ConstantVelocityComponent.direction = start_direction

func set_start_speed(start_speed: float):
	self.start_speed = start_speed
	$ConstantVelocityComponent.speed = start_speed
