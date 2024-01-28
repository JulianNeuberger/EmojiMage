extends Node2D


@export var _wand_resource: WandResource

@onready var bullet_spawner = $BulletSpawner
@onready var wand_sprite = $WandSprite
@onready var emoji_sprite = $WandSprite/EmojiSprite
@onready var start_pos: Vector2 = position

var _effect_player: PackedScene = preload("res://HitEffects/effect_player.tscn")
var _player: Wizard
var _camera_shake: CameraShake


func _ready():
	if _wand_resource:
		set_wand_resorce(_wand_resource)
	var player_group = get_tree().get_nodes_in_group("player")
	if player_group != null and len(player_group) > 0:
		_player = player_group[0]
	if _player != null:
		var camera = _player.find_child("Camera2D")
		if camera == null: 
			return
		_camera_shake = camera.find_child("CameraShake")


func set_wand_resorce(wand_resource: WandResource):
	if wand_resource:
		bullet_spawner.bullet_resource = wand_resource.bullet_resource
		bullet_spawner.bullet_spread = wand_resource.bullet_spread
		bullet_spawner.bullets_per_shot = wand_resource.bullets_per_shot
		bullet_spawner.shots_per_second = wand_resource.shots_per_second
		bullet_spawner.bullet_speed_variance = wand_resource.bullet_speed_variance
		bullet_spawner.generate_delay_time()
		emoji_sprite.texture = wand_resource.sprite
		emoji_sprite.visible = true
		wand_sprite.visible = true
	else:
		wand_sprite.visible = false
		emoji_sprite.visible = false
		
	_wand_resource = wand_resource
	
	var wand_name = "not set"
	if _wand_resource:
		wand_name = _wand_resource.name
	
func shoot():
	if _wand_resource == null: 
		return
	var did_shoot = bullet_spawner.trigger_bullet_spawn()
	if not did_shoot: 
		return
	_play_effect(_wand_resource.shoot_effect)
	_shake_camera()
	_animate()

func _shake_camera():
	if _camera_shake == null:
		return
	_camera_shake.shake_camera(_wand_resource.camera_shake)

func _play_effect(effect: HitEffectAttributes):
	var tree = get_tree()
	if tree == null: 
		# level already finished
		return
	var player: HitEffectPlayer = _effect_player.instantiate()
	tree.root.add_child(player)
	player.global_position = emoji_sprite.global_position
	player.global_rotation = global_rotation
	player.play(effect, self)

func _animate():
	if _wand_resource == null:
		return
	var tween = get_tree().create_tween()
	var half_animation_time = 0.5 / _wand_resource.shots_per_second
	tween.tween_property(self, "position", start_pos + Vector2(10, 0), half_animation_time)
	tween.chain().tween_property(self, "position", start_pos, half_animation_time)
