class_name CharacterStateFall extends CharacterState

## A value greater than 1.0 makes the player fall faster.
## [br]A value less than one makes the character floaty as they fall.
@export var fall_gravity_multiplier: float = 1.0


func _activate_state() -> void:
	super()
	set_physics_process(true)


func _enter_state() -> void:
	super()
	character.set_move_state(GameConstants.MoveState.FALL)
	can_transition = false


# If the player is falling, switch to the Fall state.
# If the player is not on the floor, apply gravity.
func _physics_process(delta: float) -> void:
	if not character.is_on_floor() and character.velocity.y < 0.0:
		switch_state()
	character.apply_gravity(delta, fall_gravity_multiplier) #Always apply gravity
	if character.is_on_floor():
		can_transition = true
