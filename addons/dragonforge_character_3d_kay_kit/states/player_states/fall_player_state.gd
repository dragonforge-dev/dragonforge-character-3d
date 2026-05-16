class_name FallPlayerState extends PlayerState

## A value greater than 1.0 makes the player fall faster.
## [br]A value less than one makes the character floaty as they fall.
@export var fall_gravity_multiplier: float = 1.0


func _activate_state() -> void:
	super()
	set_process(true)


func _enter_state() -> void:
	super()
	set_physics_process(true)


func _exit_state() -> void:
	super()
	set_physics_process(false)


# If the player is falling, switch to the Fall state.
func _process(_delta: float) -> void:
	if not is_current_state() \
	and not character.is_on_floor() \
	and not get_current_state() is JumpPlayerState:
		switch_state()


# If the player is not on the floor, apply gravity.
func _physics_process(delta: float) -> void:
	character.apply_gravity(delta, fall_gravity_multiplier) #Always apply gravity
	
	character.direction = _get_input_direction()
	character.velocity.x = character.direction.x * character.speed
	character.velocity.z = character.direction.z * character.speed


func _get_input_direction() -> Vector3:
	var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	return character.cameras.get_facing(input_vector, character.transform.basis)
