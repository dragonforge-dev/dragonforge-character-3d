class_name CharacterStateIdle extends CharacterState


func _activate_state() -> void:
	super()
	# Keep physics processing off until the character is fully constructed, so
	# that the idle state doesn't try to call the animations before they exist.
	character.ready.connect(_on_character_ready)


## Once the character is complete, then we can start processing. So even if the state is activated
## it's not fully on.
func _on_character_ready() -> void:
	set_process(true)
	set_physics_process(true)


## If the character stops moving, move to the Idle state.
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
