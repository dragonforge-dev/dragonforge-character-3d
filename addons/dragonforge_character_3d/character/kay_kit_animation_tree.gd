class_name KayKitAnimationTree extends AnimationTree

@onready var move_state_machine = get("parameters/MoveStateMachine/playback") as AnimationNodeStateMachinePlayback


func set_move_state(move_state: GameConstants.MoveState) -> void:
	match move_state:
		GameConstants.MoveState.IDLE:
			_set_move_state("Idle")
		GameConstants.MoveState.RUN:
			_set_move_state("Running_A")
		GameConstants.MoveState.JUMP:
			_set_move_state("Jump_Idle")
		GameConstants.MoveState.FALL:
			_set_move_state("Jump_Idle")


func block_change(value: float) -> void:
	set("parameters/BlockBlend/blend_amount", value)


func _set_move_state(state_name: String):
	move_state_machine.travel(state_name)
