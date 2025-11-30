class_name PlayerStateJump extends PlayerState

@export var jump_velocity: float = 10.0
@export var jump_sound: AudioStream


func _activate_state() -> void:
	super()
	set_physics_process(true)


func _enter_state() -> void:
	super()
	can_transition = false
	character.velocity.y = jump_velocity
	character.set_move_state(GameConstants.MoveState.JUMP)
	if jump_sound:
		jump_sound.play()


# If the player presses the Jump action, switch to the Jump state.
# If the player is not on the floor, apply gravity.
func _physics_process(delta: float) -> void:
	if character.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			switch_state()
	elif character.velocity.y > 0.0:
		character.apply_gravity(delta)
	elif character.velocity.y <= 0.0 or character.is_on_floor():
		can_transition = true
