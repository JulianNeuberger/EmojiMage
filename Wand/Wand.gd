extends Node2D
@export var _wand_resource: WandResource
@onready var bullet_spawner = $BulletSpawner
@onready var wand_sprite = $Sprite2D


func _ready():
	if _wand_resource:
		set_wand_resorce(_wand_resource)


func set_wand_resorce(wand_resource: WandResource):
	if wand_resource:
		bullet_spawner.bullet_resource = wand_resource.bullet_resource
		bullet_spawner.bullet_spread = wand_resource.bullet_spread
		bullet_spawner.bullets_per_shot = wand_resource.bullets_per_shot
		bullet_spawner.shots_per_second = wand_resource.shots_per_second
		bullet_spawner.bullet_speed_variance = wand_resource.bullet_speed_variance
		wand_sprite.texture = wand_resource.sprite
		wand_sprite.visible = true
	else:
		wand_sprite.visible = false
		
	_wand_resource = wand_resource
	
func shoot():
	if _wand_resource:
		bullet_spawner.trigger_bullet_spawn()
