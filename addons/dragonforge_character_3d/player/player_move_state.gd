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
	character.velocity.x = character.direction.x * character.speed
	character.velocity.z = character.direction.z * character.speed
	
	do_animation()
	character.move_and_slide()


## Handles Idle/Walk/Run Animation
func do_animation() -> void:
	var vl = character.direction * character.rig.transform.basis
	character.animation_tree.set(character.IDLE_WALK_RUN_BLEND_POSITION, Vector2(vl.x, -vl.z))
