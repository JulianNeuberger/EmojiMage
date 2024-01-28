extends Node
class_name CameraShake


@onready var camera: Camera2D = get_parent()

var _shake_attributes
var _shake_started_seconds

func shake_camera(camera_shake_attributes: CameraShakeAttributes):
	_reset()
	if camera_shake_attributes == null:
		return
	_shake_started_seconds = Time.get_ticks_msec() / 1000.0
	_shake_attributes = camera_shake_attributes

func _reset():
	camera.position = Vector2.ZERO
	_shake_attributes = null

func _process(delta):
	if _shake_attributes == null:
		return
	
	var now_seconds = Time.get_ticks_msec() / 1000.0
	var t: float = (now_seconds - _shake_started_seconds) / _shake_attributes.duration
	if t < 0:
		_reset()
		return
	
	if t > 1:
		_reset()
		return
	
	var offset = _shake_attributes.curve.sample(t) * _shake_attributes.intensity
	camera.position.x += offset
	camera.position.y += offset
