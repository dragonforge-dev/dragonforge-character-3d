class_name MovePlayerState extends PlayerState


func _activate_state() -> void:
	super()
	set_process(true)


func _enter_state() -> void:
	super()
	character.set_move_state(GameConstants.MoveState.RUN)
	set_physics_process(true)


func _exit_state() -> void:
	super()
	set_physics_process(false)


## If the player has directional input, move to the Move state.
func _process(_delta: float) -> void:
	character.direction = _get_input_direction()
	
	if not is_current_state() \
	and character.is_on_floor() \
	and character.direction \
	and not get_current_state() is JumpPlayerState:
		switch_state()


## Handles movement and animation
func _physics_process(_delta: float) -> void:
	character.velocity.x = character.direction.x * character.speed
	character.velocity.z = character.direction.z * character.speed


func _get_input_direction() -> Vector3:
	var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	return character.cameras.get_facing(input_vector, character.transform.basis)
