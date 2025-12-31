@icon("res://addons/dragonforge_character_3d/assets/textures/icons/pencil.svg")
class_name StatResource extends Resource


signal zero
signal update


enum Type {
	Speed,
	JumpVelocity
}


@export var stat_type: Type
@export var stat_value: float:
	set(value):
		stat_value = clampf(value, 0, INF)
		update.emit()
		if stat_value == 0.0:
			zero.emit()
