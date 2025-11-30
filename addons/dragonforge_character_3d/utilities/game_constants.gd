class_name GameConstants

# Inputs
const INPUT_MOVE_LEFT = "move_left"
const INPUT_MOVE_RIGHT = "move_right"
const INPUT_MOVE_FORWARD = "move_forward"
const INPUT_MOVE_BACKWARD = "move_backward"
const INPUT_JUMP = "jump"

# Notifications
const NOTIFICATION_ENTER_STATE: int = 5001
const NOTIFICATION_EXIT_STATE: int = 5002

#Enums
enum MoveState {
	IDLE,
	RUN,
	JUMP,
	FALL,
}
