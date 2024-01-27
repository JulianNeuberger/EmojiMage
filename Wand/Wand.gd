extends Node2D
@export var wand_resource: WandResource
@onready var bullet_spawner = $BulletSpawner

func _ready():
	set_wand_resorce(wand_resource)


func set_wand_resorce(wand_resource: WandResource):
	bullet_spawner.bullet_resource = wand_resource.bullet_resource
	
	
func shoot():
	if wand_resource:
		bullet_spawner.spawn_bullet()
