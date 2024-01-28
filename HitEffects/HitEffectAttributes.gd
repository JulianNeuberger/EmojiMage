extends Resource
class_name HitEffectAttributes


@export var sounds: Array[AudioStream]
@export var pitch_variation: float = 1.0
@export var volume_adjust: float = 1.0

@export var particle_texture: Texture2D
@export var particle_emit_duration: float
@export var particle_color: Color = Color(1, 1, 1)
@export var particle_amount: int = 25
@export var particle_explosiveness: float = 0.0
@export var particle_frames: int = 1
@export var particle_oneshot: bool = true
@export var particle_emit_angle_degree: float = 45.0
@export var particle_speed_min: float = 75
@export var particle_speed_max: float = 100

@export var flash_duration: float = .05
