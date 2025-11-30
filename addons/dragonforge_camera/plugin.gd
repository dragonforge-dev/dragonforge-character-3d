@tool
extends EditorPlugin

const CHANGE_CAMERA = "change_camera"


func _enable_plugin() -> void:
	add_action(CHANGE_CAMERA, JOY_BUTTON_RIGHT_STICK, MOUSE_BUTTON_NONE, KEY_C)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func _disable_plugin() -> void:
	remove_action(CHANGE_CAMERA)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func add_action(action: StringName, gamepad_button: JoyButton, mouse_button: MouseButton, key: Key) -> void:
	var input_map = {
		"deadzone": 0.2,
		"events": []
	}
	
	if gamepad_button != JOY_BUTTON_INVALID:
		var event_gamepad = InputEventJoypadButton.new()
		event_gamepad.button_index = gamepad_button
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
	
