@icon("res://addons/dragonforge_camera/assets/icons/video-camera-mount.svg")
class_name CameraMount3D extends Node3D


const HEAD_VISIBILITY_LAYER = 2

## How far up the camera will rotate in degrees.
@export var upwards_rotation_limit: float = 0.0
## How far down the camera will rotate in degrees.
@export var downwards_rotation_limit: float = 0.0
## If true, camera is a first-person camera. Otherwise, third-person.
@export var first_person: bool = false


@onready var spring_arm_3d: SpringArm3D = $SpringArm3D
@onready var camera_3d: Camera3D = $SpringArm3D/Camera3D
@onready var horizontal_pivot: Node3D = $"Horizontal Pivot"
@onready var vertical_pivot: Node3D = $"Horizontal Pivot/Vertical Pivot"


func _ready() -> void:
	if first_person:
		spring_arm_3d.spring_length = 0.0
		spring_arm_3d.rotation.x = 0.0
		camera_3d.set_cull_mask_value(HEAD_VISIBILITY_LAYER, false) #Turning off the layer the head model is on.


func _physics_process(delta: float) -> void:
	update_rotation()


func make_current() -> void:
	reset_rotation()
	camera_3d.make_current()


func update_rotation() -> void:
	horizontal_pivot.rotate_y(Controller.look.x)
	vertical_pivot.rotate_x(Controller.look.y)
	vertical_pivot.rotation.x = clampf(vertical_pivot.rotation.x,
		deg_to_rad(upwards_rotation_limit),
		deg_to_rad(downwards_rotation_limit)
	)
	apply_rotation()
	
	if Controller.get_last_input_type() == Controller.LastInput.KEYBOARD_AND_MOUSE:
		Controller.look = Vector2.ZERO


func apply_rotation() -> void:
	spring_arm_3d.rotation.y = horizontal_pivot.rotation.y
	camera_3d.rotation.x = vertical_pivot.rotation.x


func reset_rotation() -> void:
	horizontal_pivot.rotation.y = 0.0
	vertical_pivot.rotation.x = 0.0
	apply_rotation()
