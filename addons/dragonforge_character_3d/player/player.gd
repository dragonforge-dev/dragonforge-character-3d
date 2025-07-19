class_name Player extends Character


@export var rig: Node3D
## The speed at which the player turns.
@export var animation_decay: float = 20.0


@onready var cameras: Cameras = $Cameras


var direction := Vector3.ZERO


func _physics_process(delta: float) -> void:
	super(delta)

	direction = get_input_direction()
	
	if velocity.length() > 1.0 and direction != Vector3.ZERO:
		look_toward_direction(delta)


func get_input_direction() -> Vector3:
	var camera = cameras.active_camera
	var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	if camera is CameraMount3D:
		return camera.horizontal_pivot.global_transform.basis * input_vector
	elif camera.rotation.y != 0.0:
		return input_vector.rotated(Vector3.UP, camera.rotation.y).normalized()
	else:
		return transform.basis * input_vector


func look_toward_direction(delta: float) -> void:
	var target := rig.global_transform.looking_at(rig.global_position + direction, Vector3.UP)
	rig.global_transform = rig.global_transform.interpolate_with(target, 1.0 - exp(-animation_decay * delta))
