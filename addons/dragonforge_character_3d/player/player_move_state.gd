class_name PlayerMoveState extends PlayerState


func _activate_state() -> void:
	super()
	set_process(true)
	set_physics_process(true)


## If the player has directional input, move to the Move state.
func _process(_delta: float) -> void:
	if character.direction:
		switch_state()


## Handles movement and animation
func _physics_process(_delta: float) -> void:
	character.direction = get_input_direction()
	
	character.velocity.x = character.direction.x * character.speed
	character.velocity.z = character.direction.z * character.speed
	
	do_animation()
	character.move_and_slide()


func get_input_direction() -> Vector3:
	var camera = character.cameras.active_camera
	var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	if camera is CameraMount3D:
		return camera.horizontal_pivot.global_transform.basis * input_vector
	elif camera.rotation.y != 0.0:
		return input_vector.rotated(Vector3.UP, camera.rotation.y).normalized()
	else:
		return character.transform.basis * input_vector


## Handles Idle/Walk/Run Animation
func do_animation() -> void:
	var vl = character.direction * character.rig.transform.basis
	character.animation_tree.set(character.IDLE_WALK_RUN_BLEND_POSITION, Vector2(vl.x, -vl.z))
