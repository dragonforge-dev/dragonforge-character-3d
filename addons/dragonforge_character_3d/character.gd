class_name Character extends CharacterBody3D


const IDLE_WALK_RUN_BLEND_POSITION = "parameters/IdleWalkRun/blend_position"


@export var stats: Array[StatResource]
@export var state_machine: StateMachine
@export var animation_tree: AnimationTree:
	set(value):
		animation_tree = value
		animation_state = animation_tree.get("parameters/playback")


## Top Speed defaults to 5.0 unless the Speed stat is assigned, then that
## number is used.
@onready var speed: float = get_stat_value(StatResource.Type.Speed, 5.0)


var animation_state


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


func get_stat(stat: StatResource.Type) -> StatResource:
	for element in stats:
		if element.stat_type == stat:
			return element
	return null


func get_stat_value(stat: StatResource.Type, default: float = 0.0):
	var stat_resource = get_stat(stat)
	if stat_resource:
		return stat_resource.stat_value
	return default
