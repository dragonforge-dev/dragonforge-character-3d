class_name JumpPlayerState extends PlayerState

@export var jump_velocity: float = 10.0
## A value greater than 1.0 makes the player jump slower and for less height.
## [br]A value less than one makes the character jump faster and higher.
@export var jump_gravity_multiplier: float = 1.0
@export var jump_sound: AudioStream


func _activate_state() -> void:
	super()
	set_process(true)


func _enter_state() -> void:
	super()
	character.velocity.y = jump_velocity
	character.set_move_state(GameConstants.MoveState.JUMP)
	if jump_sound:
		jump_sound.play()
	set_physics_process(true)
	character.animation_tree.animation_finished.connect(_on_animation_finished)


func _exit_state() -> void:
	set_physics_process(false)


# If the player presses the Jump action, switch to the Jump state.
func _process(_delta: float) -> void:
	if not is_current_state() \
	and Input.is_action_just_pressed("jump") \
	and character.is_on_floor():
		switch_state()


# If the player is not on the floor, apply gravity.
func _physics_process(delta: float) -> void:
	#if character.velocity.y > 0.0:
	character.apply_gravity(delta, jump_gravity_multiplier)

	character.direction = _get_input_direction()
	character.velocity.x = character.direction.x * character.speed
	character.velocity.z = character.direction.z * character.speed


func _on_animation_finished(state_name: StringName) -> void:
	if state_name.contains("jump"):
		clear_state()
		character.animation_tree.animation_finished.disconnect(_on_animation_finished)


func _get_input_direction() -> Vector3:
	var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	return character.cameras.get_facing(input_vector, character.transform.basis)
