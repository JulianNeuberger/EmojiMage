extends CharacterBody2D

class_name EnemyBehavior

@onready var health_component: Health = $Health
@export var change_interval_miliseconds: float = 2000
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var movement: EnemyMovement = $EnemyMovement

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
	movement.set_nav_agent(navigation_agent)

func _process(delta):
	for child in $Behaviors.get_children():
		if is_disabled and not child.is_processing() and start_time + change_interval_miliseconds <= Time.get_ticks_msec():
			child.set_process(true)
			is_disabled = false
			
		elif not is_disabled:
			child.set_process(false)
			is_disabled = true
			start_time = Time.get_ticks_msec()
	
func set_target(target: Node2D):
	for child in $Behaviors.get_children():
		child.target = target

