class_name FallCharacterState extends CharacterState

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
	and not character.is_on_floor():
		switch_state()


# If the player is not on the floor, apply gravity.
func _physics_process(delta: float) -> void:
	character.apply_gravity(delta, fall_gravity_multiplier) #Always apply gravity
