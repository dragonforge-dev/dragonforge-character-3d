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


## Activates the first camera in the list.
func _ready() -> void:
	next_camera()


## Calls next_camera() when the "change_camera" action fires.
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
