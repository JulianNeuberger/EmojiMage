extends Node2D
class_name HitEffectPlayer


@onready var particle_system: CPUParticles2D = $CPUParticles2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = get_parent().find_child("Sprite2D")

var _particle_emitting_duration: float = 0
var _flash_duration: float = 0


func play_effect(hit_effect_attributes: HitEffectAttributes):
	#particle_system.texture = hit_effect_attributes.splatter_texture
	_particle_emitting_duration = .2
	_flash_duration = hit_effect_attributes.flash_duration
	
	var hit_sound = hit_effect_attributes.hit_sounds.pick_random()
	audio_stream_player.stream = hit_sound
	audio_stream_player.pitch_scale = randf_range(
		1 - hit_effect_attributes.pitch_variation, 
		1 + hit_effect_attributes.pitch_variation
	)
	audio_stream_player.play()

func _process(delta):
	particle_system.emitting = _particle_emitting_duration > 0
	if _flash_duration > 0:
		sprite.modulate = Color(1, .2, .2)
	else:
		sprite.modulate = Color(1, 1, 1)
	
	_particle_emitting_duration -= delta
	_flash_duration -= delta
