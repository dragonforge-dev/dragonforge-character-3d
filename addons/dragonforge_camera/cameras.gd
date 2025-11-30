@icon("res://addons/dragonforge_camera/assets/icons/video-camera-round.svg")
class_name Cameras extends Node3D

## The cameras available to the player. Pressing the change_camera button will
## switch to the next camera in the list. The list is constructed when this
## object is first created, and is made of all the child nodes one level down
## that are either Camera3D of CameraMount3D nodes.
@onready var available_cameras: Array[Node3D] = inititalize_cameras()
@onready var active_camera_iterator: int = -1
## A reference to the currently active camera. This currently ONLY tracks
## cameras the player has control over (by switching). Any cutscene cameras,
## etc. will not be assigned to this variable.
@onready var active_camera: Node3D = get_first_camera()


# Activates the first camera in the list.
func _ready() -> void:
	next_camera()


# Calls next_camera() when the "change_camera" action fires.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("change_camera"):
		next_camera()


## Activates the next camera in the list.
func next_camera() -> void:
	if available_cameras == null:
		return
	active_camera_iterator += 1
	if active_camera_iterator >= available_cameras.size():
		active_camera_iterator = 0
	change_camera(available_cameras[active_camera_iterator])
	print("Camera Mode Selected: %s" % active_camera.name)


## Return the first Camera3D or CameraMount3D found that is a child of this node.
func get_first_camera() -> Node3D:
	for node in get_children():
		if node is Camera3D or node is CameraMount3D:
			return node
	return null


## Return a list of all Camera3D and CameraMount3D nodes that are children of this node.
func inititalize_cameras() -> Array[Node3D]:
	var return_value: Array[Node3D]
	for node in get_children():
		if node is Camera3D or node is CameraMount3D:
			return_value.append(node)
	return return_value


## Makes the passed camera the active camera.
func change_camera(camera: Node3D) -> void:
	active_camera.set_physics_process(false)
	camera.make_current()
	camera.set_physics_process(true)
	active_camera = camera


# TODO: Move this into the cameras to return.
## Returns the direction for a [CharacterBody3D] based on the passed input vector
## and the [member Characterbody.transform.basis]. If the active camera is 1st
## person, 3rd person free look or 3rd person follow, the player will point in
## the direction of the camera. If the camera is a 3rd person fixed, ISO or birds
## eye view camera, it will just reflect the actual direction the input is moving
## the player.
func get_facing(input_vector: Vector3, character_transform_basis: Basis) -> Vector3:
	if active_camera is CameraMount3D:
		return active_camera.horizontal_pivot.global_transform.basis * input_vector
	elif active_camera.rotation.y != 0.0:
		return input_vector.rotated(Vector3.UP, active_camera.rotation.y).normalized()
	else: #If this is a fixed camera, we don't change the player facing based on it.
		return character_transform_basis * input_vector
