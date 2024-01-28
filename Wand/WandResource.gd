extends Resource
class_name WandResource

@export var name: String
@export var shots_per_second: float
@export var bullet_spread: float = 0.1
@export var bullet_resource: BulletResource
@export var bullets_per_shot: int = 1
@export var bullet_speed_variance: int = 50
@export var sprite: Texture
@export var camera_shake: CameraShakeAttributes
