class_name PlayerStateBlock extends PlayerState

var is_defending: bool = false:
	set(value):
		if not is_defending and value:
			character.block_toggle(true)
		if is_defending and not value:
			character.block_toggle(false)
		is_defending = value


func _activate_state() -> void:
	super()
	set_physics_process(true)


func _physics_process(_delta: float) -> void:
	is_defending = Input.is_action_pressed("block")
