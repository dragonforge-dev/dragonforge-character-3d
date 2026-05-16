class_name GameConstants

#Filepaths
const MATERIALS_PATH = "res://assets/materials/"
const TEXTURES_PATH = "res://assets/textures/"

# Inputs
const INPUT_MOVE_LEFT = "move_left"
const INPUT_MOVE_RIGHT = "move_right"
const INPUT_MOVE_FORWARD = "move_forward"
const INPUT_MOVE_BACKWARD = "move_backward"
const INPUT_JUMP = "jump"

#Layers
const ENVIRONMENT_LAYER = 1 # Layer 1
const PLAYER_LAYER = 2 # Layer 2
const ENEMY_LAYER = 4 # Layer 3
const NPC_LAYER = 8 # Layer 4

#Enums
enum MoveState {
	IDLE,
	RUN,
	JUMP,
	FALL,
}


enum AnimationType {
	IDLE,
	RUN,
	JUMP,
	FALL,
	PRIMARY_ATTACK,
	SECONDARY_ATTACK,
}
