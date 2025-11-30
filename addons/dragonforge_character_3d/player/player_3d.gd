class_name Player3D extends Character3D

## The speed at which the player turns.
@export var turn_speed: float = 20.0

var direction := Vector3.ZERO
var rig: Node3D

@onready var cameras: Cameras = $Cameras


func _ready() -> void:
	super()
	rig = skin.get_child(0) #Assumes the rig is the first node in the skin.
	_set_head_visibility_layer(rig, 2) #Make it so in 1st person mode the head is invisible.


func _physics_process(delta: float) -> void:
	if velocity.length() > 1.0 and direction != Vector3.ZERO:
		look_toward(direction, delta)
	
	move_and_slide()


#Move this to the rig code?
func look_toward(direction: Vector3, delta: float) -> void:
	var target := rig.global_transform.looking_at(rig.global_position + direction, Vector3.UP)
	rig.global_transform = rig.global_transform.interpolate_with(target, 1.0 - exp(-turn_speed * delta))


#Sets the visibility layer so the player can see through the model's head when in first person mode.
func _set_head_visibility_layer(node: Node, layer) -> void:
	for subnode in node.get_children():
		if subnode is MeshInstance3D and subnode.name.contains("Head"):
			subnode.layers = layer
		_set_head_visibility_layer(subnode, layer)
	
	
	
	
