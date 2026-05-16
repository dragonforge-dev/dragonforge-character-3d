class_name ChaseEnemyState extends EnemyState

@onready var player_detector_area_3d: Area3D = %PlayerDetectorArea3D
@onready var navigation_agent_3d: NavigationAgent3D = %NavigationAgent3D

var target: KayKitCharacter3D


func _activate_state() -> void:
	super()
	player_detector_area_3d.body_entered.connect(_on_player_detected)
	player_detector_area_3d.body_exited.connect(_on_player_lost)
	set_process(true)


# We start chasing the player.
func _enter_state() -> void:
	super()
	character.set_move_state(GameConstants.MoveState.RUN)
	set_physics_process(true)


# We stop chasing the player.
func _exit_state() -> void:
	super()
	set_physics_process(false)


## Handles movement and animation
func _physics_process(delta: float) -> void:
	#character.velocity = Vector3.ZERO
	#character.look_at_target_smooth(target, delta)
	#navigation_agent_3d.target_position = target.global_position
	character.direction = character.global_position.direction_to(target.global_position)
	navigation_agent_3d.target_position = target.global_transform.origin
	var next_path_pos = navigation_agent_3d.get_next_path_position()
	#character.velocity.x = move_toward(character.global_position.direction_to(next_path_pos).x, 0, character.speed * delta)
	#character.velocity.z = move_toward(character.global_position.direction_to(next_path_pos).z, 0, character.speed * delta)
	#character.velocity = character.global_position.direction_to(next_path_pos) * character.speed
	#character.velocity = (next_path_pos - character.global_position).normalized() * character.speed * delta
	#character.velocity = (next_path_pos - character.global_transform.origin).normalized() * character.speed

#func _get_input_direction() -> Vector3:
	#var input_dir := Input.get_vector(GameConstants.INPUT_MOVE_LEFT, GameConstants.INPUT_MOVE_RIGHT,
									#GameConstants.INPUT_MOVE_FORWARD, GameConstants.INPUT_MOVE_BACKWARD)
	#var input_vector := Vector3(input_dir.x, 0, input_dir.y) #.normalized()
	#return character.cameras.get_facing(input_vector, character.transform.basis)


func _on_player_detected(player: Node3D) -> void:
	print("Player Detected")
	target = player
	switch_state()


func _on_player_lost(_player: Node3D) -> void:
	character.direction = Vector3.ZERO
	clear_state()
