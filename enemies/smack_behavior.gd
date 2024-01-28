extends Node

class_name SmackBehavior

@export var target: Node2D
@export var movement: EnemyMovement
@export var smacking_distance: float = 30
@export var smacking_damage: float = 10
@export var smacks_per_sec: float = 2
@onready var stick_sprite = get_parent().get_parent().find_child("StickSprite")

var stick_start_rotation: float 
var stick_start_position: Vector2
var last_smack: float = -1
var target_health: Health

var classname: String = "smack"

func set_target(target: Node2D):
	self.target = target
	target_health = target.find_child("Health")

func animate():
	stick_start_rotation = stick_sprite.rotation
	stick_start_position = stick_sprite.position
	stick_sprite.rotation = stick_start_rotation - PI/2
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(stick_sprite, "rotation", stick_start_rotation + PI/2, (1/smacks_per_sec)/2)
	tween.chain().tween_property(stick_sprite, "rotation", stick_start_rotation, (1/smacks_per_sec)/2)

func rotate_user():
	var enemy = get_parent().get_parent()
	var target_direction = (target.global_position - enemy.global_position).normalized()
	stick_sprite.global_position = enemy.global_position + target_direction * 25
	stick_sprite.rotation = Vector2.RIGHT.angle_to(target_direction)
	
func _process(delta):
	if target == null: 
		return
	
	rotate_user()
	if smacking_distance < (target.global_position - movement.global_position).length():
		return 
	
	var current_time_sec = Time.get_ticks_msec()/1000
	if current_time_sec < last_smack + 1/smacks_per_sec:
		return
	
	animate()
	target_health.damage(smacking_damage)
	last_smack = current_time_sec

func can_make_transition(current_state):
	if target == null:
		return false
		
	if smacking_distance >= (target.global_position - movement.global_position).length():
		return true
	return false
