class_name PlayerIdleState extends PlayerState


func _activate_state() -> void:
	super()
	set_process(true)
	set_physics_process(true)


## If the player stops moving, move to the Idle state.
func _process(_delta: float) -> void:
	if character.direction == Vector3.ZERO:
		switch_state()


## Handles slowing movement and idle animation
func _physics_process(_delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, character.speed)
	character.velocity.z = move_toward(character.velocity.z, 0, character.speed)

	do_animation()
	character.move_and_slide()


## Handles Idle/Walk/Run Animation
func do_animation() -> void:
	var vl = character.direction * character.rig.transform.basis
	character.animation_tree.set(character.IDLE_WALK_RUN_BLEND_POSITION, Vector2(vl.x, -vl.z))
