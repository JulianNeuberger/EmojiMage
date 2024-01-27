extends CharacterBody2D

class_name EnemyBehavior

@onready var health_component: Health = $Health
@export var change_interval_miliseconds: float = 2000
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var movement: EnemyMovement = $EnemyMovement
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
	movement.set_nav_agent(navigation_agent)

func _process(delta):
	for child in $Behaviors.get_children():
		if child.can_make_transition(state):
			state = child
			child.set_process(true)
		else:
			child.set_process(false)
	
func set_target(target: Node2D):
	for child in $Behaviors.get_children():
		child.target = target

