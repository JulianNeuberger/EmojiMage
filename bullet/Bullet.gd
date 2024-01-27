extends CharacterBody2D
class_name Bullet

@export var damage: int = 1
@export var start_direction: Vector2
@export var bullet_resource: BulletResource
@export var time_to_life: int = 3


func _ready():
	$HitBox.trigger.connect(on_bullet_hit)
	set_start_direction(start_direction)
	set_bullet_resource(bullet_resource)
	var timer = Timer.new()
	self.add_child(timer)
	
	timer.timeout.connect(queue_free)
	timer.set_wait_time(time_to_life)
	timer.start()

func _process(delta):
	move_and_slide()

func on_bullet_hit(target: HurtBox):
	#animation
	queue_free()

func set_start_direction(start_direction: Vector2):
	self.start_direction = start_direction
	$ConstantVelocityComponent.direction = start_direction

func set_bullet_resource(bullet_resource:BulletResource):
	self.bullet_resource = bullet_resource
	$ConstantVelocityComponent.speed = bullet_resource.speed
