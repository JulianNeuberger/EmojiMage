extends Node2D
class_name HitEffectPlayer

@onready var particle_system: CPUParticles2D = $CPUParticles2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var _sprite: AnimatedSprite2D
var _particle_emitting_duration: float = 0
var _flash_duration: float = 0
var _audio_finished: bool = false


func play(effect_attributes: HitEffectAttributes, effect_root: Node2D):
	if effect_attributes == null:
		return
	
	if effect_root != null:
		_sprite = effect_root.find_child("AnimatedSprite2D")
	
	particle_system.texture = effect_attributes.particle_texture
	particle_system.modulate = effect_attributes.particle_color
	particle_system.explosiveness = effect_attributes.particle_explosiveness
	particle_system.amount = effect_attributes.particle_amount
	particle_system.one_shot = effect_attributes.particle_oneshot
	particle_system.material.particles_anim_h_frames = effect_attributes.particle_frames
	particle_system.spread = effect_attributes.particle_emit_angle_degree
	particle_system.initial_velocity_min = effect_attributes.particle_speed_min
	particle_system.initial_velocity_max = effect_attributes.particle_speed_max
	
	_particle_emitting_duration = effect_attributes.particle_emit_duration
	_flash_duration = effect_attributes.flash_duration
	
	_audio(effect_attributes)
	
	
func _audio(effect_attributes: HitEffectAttributes):
	if effect_attributes.sounds == null or len(effect_attributes.sounds) == 0:
		_audio_finished = true
		return
	var sound = effect_attributes.sounds.pick_random()
	audio_stream_player.stream = sound
	audio_stream_player.pitch_scale = randf_range(
		1 - effect_attributes.pitch_variation, 
		1 + effect_attributes.pitch_variation
	)
	audio_stream_player.volume_db += effect_attributes.volume_adjust
	audio_stream_player.play()
	audio_stream_player.connect("finished", func(): _audio_finished = true)

func _flash(delta):
	if _sprite == null:
		return
	if _flash_duration > 0:
		_sprite.modulate = Color(1, .2, .2)
	else:
		_sprite.modulate = Color(1, 1, 1)
	_flash_duration -= delta

func _particles(delta):
	if particle_system.one_shot:
		particle_system.emitting = true
	else:
		particle_system.emitting = _particle_emitting_duration > 0
		_particle_emitting_duration -= delta

func _process(delta):
	_flash(delta)
	_particles(delta)
	
	var dead = _flash_duration <= 0 and not particle_system.emitting and _audio_finished
	if dead:
		# wait for all particles to die
		await get_tree().create_timer(particle_system.lifetime).timeout
		queue_free()
