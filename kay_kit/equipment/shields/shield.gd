class_name Shield extends Item

var hit_sound_player: AudioStreamPlayer3D

func _ready() -> void:
	hit_sound_player.stream = resource.hit_sound
