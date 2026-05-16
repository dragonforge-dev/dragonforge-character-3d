extends PlayerState

@export var attack_sound: AudioStream


func _activate_state() -> void:
	super()
	set_process(true)


func _enter_state() -> void:
	super()
	character.trigger_animation(GameConstants.AnimationType.PRIMARY_ATTACK)
	if attack_sound:
		attack_sound.play()
	set_physics_process(true)
	character.animation_tree.animation_finished.connect(_on_animation_finished)


# If the player presses the Primary Attack action, switch to the Attack State state.
func _process(_delta: float) -> void:
	if not is_current_state() \
	and Input.is_action_just_pressed("primary_attack"):
		switch_state()


func _on_animation_finished(state_name: StringName) -> void:
	if state_name.contains("combat"):
		clear_state()
		character.animation_tree.animation_finished.disconnect(_on_animation_finished)
