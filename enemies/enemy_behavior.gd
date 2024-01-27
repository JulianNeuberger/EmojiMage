extends CharacterBody2D

class_name EnemyBehavior

@onready var health_component: Health = $Health
@export var change_interval_miliseconds: float = 2000

@onready var state: Node = $Behaviors/FollowBehavior

var start_time := Time.get_ticks_msec()
var is_disabled: bool = false

signal on_death

func _propagate_death(health: Health):
	print('You died!')
	on_death.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	$HurtBox.connect("trigger", func(source: HitBox): health_component.damage(10))
	health_component.connect("on_death", _propagate_death)

func _process(delta):
	for child in $Behaviors.get_children():
		#if child.classname == 'shoot':
			#child.set_process(true)
		#else:
			#child.set_process(false)
		if child.can_make_transition(state):
			state = child
			child.set_process(true)
		else:
			child.set_process(false)
		
		#if is_disabled and not child.is_processing() and start_time + change_interval_miliseconds <= Time.get_ticks_msec():
			#child.set_process(true)
			#is_disabled = false
			#
		#elif not is_disabled:
			#child.set_process(false)
			#is_disabled = true
			#start_time = Time.get_ticks_msec()
	
func set_target(target: Node2D):
	for child in $Behaviors.get_children():
		child.target = target

