@tool
extends EditorPlugin

const MOVE_LEFT_ACTION = "move_left"
const LEFT_DIRECTION = -1.0
const MOVE_RIGHT_ACTION = "move_right"
const RIGHT_DIRECTION = 1.0
const MOVE_FORWARD_ACTION = "move_forward"
const FORWARD_DIRECTION = -1.0
const MOVE_BACKWARD_ACTION = "move_backward"
const BACKWARD_DIRECTION = 1.0
const CHANGE_CAMERA_ACTION = "change_camera"
const JUMP_ACTION = "jump"


func _enable_plugin() -> void:
	add_action(MOVE_LEFT_ACTION, JOY_BUTTON_INVALID, KEY_A, JOY_AXIS_LEFT_X, LEFT_DIRECTION)
	add_action(MOVE_RIGHT_ACTION, JOY_BUTTON_INVALID, KEY_D, JOY_AXIS_LEFT_X, RIGHT_DIRECTION)
	add_action(MOVE_FORWARD_ACTION, JOY_BUTTON_INVALID, KEY_W, JOY_AXIS_LEFT_Y, FORWARD_DIRECTION)
	add_action(MOVE_BACKWARD_ACTION, JOY_BUTTON_INVALID, KEY_S, JOY_AXIS_LEFT_Y, BACKWARD_DIRECTION)
	add_action(CHANGE_CAMERA_ACTION, JOY_BUTTON_RIGHT_STICK, KEY_C)
	add_action(JUMP_ACTION, JOY_BUTTON_A, KEY_SPACE)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func _disable_plugin() -> void:
	remove_action(MOVE_LEFT_ACTION)
	remove_action(MOVE_RIGHT_ACTION)
	remove_action(MOVE_FORWARD_ACTION)
	remove_action(MOVE_BACKWARD_ACTION)
	remove_action(CHANGE_CAMERA_ACTION)
	remove_action(JUMP_ACTION)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func add_action(action: StringName, gamepad_button: JoyButton, key: Key, gamepad_axis: JoyAxis = JOY_AXIS_INVALID, gamepad_axis_direction = 0.0, mouse_button: MouseButton = MOUSE_BUTTON_NONE) -> void:
	var input_map = {
		"deadzone": 0.2,
		"events": []
	}
	
	if gamepad_button != JOY_BUTTON_INVALID:
		var event_gamepad = InputEventJoypadButton.new()
		event_gamepad.button_index = gamepad_button
		event_gamepad.device = -1 # All devices
		input_map["events"].append(event_gamepad)
	
	if gamepad_axis != JOY_AXIS_INVALID:
		var event_gamepad = InputEventJoypadMotion.new()
		event_gamepad.axis = gamepad_axis
		event_gamepad.axis_value = gamepad_axis_direction
		event_gamepad.device = -1 # All devices
		input_map["events"].append(event_gamepad)
	
	if mouse_button != MOUSE_BUTTON_NONE:
		var event_mouse = InputEventMouseButton.new()
		event_mouse.button_index = mouse_button
		event_mouse.device = -1 # All devices
		input_map["events"].append(event_mouse)
	
	if key != KEY_NONE:
		var event_key = InputEventKey.new()
		event_key.physical_keycode = key
		input_map["events"].append(event_key)
	
	ProjectSettings.set_setting("input/" + action, input_map)
	ProjectSettings.save()


func remove_action(action: StringName) -> void:
	ProjectSettings.set_setting("input/" + action, null)
	ProjectSettings.save()
