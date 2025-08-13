extends Node3D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
