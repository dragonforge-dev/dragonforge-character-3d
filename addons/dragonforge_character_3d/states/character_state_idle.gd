class_name CharacterStateIdle extends CharacterState


func _activate_state() -> void:
	super()
	set_process(true)


# Only process physics if we are the active state.
func _enter_state() -> void:
	super()
	set_physics_process(true)
	character.set_move_state(GameConstants.MoveState.IDLE)


# Only process physics if we are the active state.
func _exit_state() -> void:
	super()
	set_physics_process(false)


## If the player stops moving, move to the Idle state.
func _process(_delta: float) -> void:
	if character.direction == Vector3.ZERO:
		switch_state()


## Handles slowing movement and idle animation
func _physics_process(delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, character.speed * delta)
	character.velocity.z = move_toward(character.velocity.z, 0, character.speed * delta)
