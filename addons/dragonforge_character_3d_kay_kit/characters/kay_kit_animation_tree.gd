@tool
class_name KayKitAnimationTree extends AnimationTree

const KAY_KIT_ANIMATION_NODE_BLEND_TREE = preload("uid://covdosp0kwwj6")

@onready var move_state_machine = get("parameters/MoveStateMachine/playback") as AnimationNodeStateMachinePlayback


func _ready() -> void:
	if Engine.is_editor_hint():
		if not tree_root:
			tree_root = KAY_KIT_ANIMATION_NODE_BLEND_TREE
	
	animation_finished.connect(_on_animation_finished)
	animation_started.connect(_on_animation_started)


func set_move_state(move_state: GameConstants.MoveState) -> void:
	match move_state:
		GameConstants.MoveState.IDLE:
			_set_move_state("Idle")
		GameConstants.MoveState.RUN:
			_set_move_state("Run")
		GameConstants.MoveState.JUMP:
			_set_move_state("Jump")
		GameConstants.MoveState.FALL:
			_set_move_state("Jump")


func trigger_animation(animation: GameConstants.AnimationType) -> void:
	match animation:
		GameConstants.AnimationType.IDLE:
			_set_move_state("Idle")
		GameConstants.AnimationType.RUN:
			_set_move_state("Run")
		GameConstants.AnimationType.JUMP:
			_set_move_state("Jump")
		GameConstants.AnimationType.FALL:
			_set_move_state("Jump")
		GameConstants.AnimationType.PRIMARY_ATTACK:
			_primary_attack()


func block_change(value: float) -> void:
	set("parameters/BlockBlend/blend_amount", value)


func _set_move_state(state_name: String):
	move_state_machine.travel(state_name)

func _primary_attack() -> void:
	set("parameters/AttackOneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)


func _on_animation_finished(state_name: String) -> void:
	print("Animation Finished: %s" % state_name)


func _on_animation_started(state_name: String) -> void:
	print("Animation Started: %s" % state_name)
