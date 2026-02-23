@tool
extends EditorPlugin

const CHANGE_CAMERA = "change_camera"


func _enable_plugin() -> void:
	Action.add(CHANGE_CAMERA, Action.joy_button(JOY_BUTTON_RIGHT_STICK), Action.key(KEY_C))
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")


func _disable_plugin() -> void:
	Action.remove(CHANGE_CAMERA)
	print_rich("[color=yellow][b]WARNING[/b][/color]: Project must be reloaded for InputMap changes to appear. [color=ivory][b]Project -> Reload Current Project[/b][/color]")
