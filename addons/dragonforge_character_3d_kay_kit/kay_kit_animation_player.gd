@tool
## An [AnimationPlayer] node that automatically loads all Medium KayKit
## animations included in the addons folder. You can point the
## [member animations_path] to another folder if you want less or different
## animations to load.
class_name KayKitAnimationPlayer extends AnimationPlayer

@export_dir var animations_path = "res://addons/dragonforge_character_3d_kay_kit/assets/animations/medium/":
	set(value):
		animations_path = value
		if Engine.is_editor_hint() and animations_path:
			add_animations()


func _ready() -> void:
	if Engine.is_editor_hint() and not get_animation_library_list() and get_parent().name.contains("Skin"):
		add_animations()


func add_animations() -> void:
	# Clear the old libraries
	for animation_library: StringName in get_animation_library_list():
		remove_animation_library(animation_library)
	
	var dir = DirAccess.open(animations_path)
	if not dir:
		return
	var animation_directories: PackedStringArray = dir.get_directories()
	for animation_dir: String in animation_directories:
		var animation_library: AnimationLibrary = AnimationLibrary.new()
		add_animation_library(animation_dir, animation_library)
		# Get the animation name
		dir.change_dir(animation_dir)
		for file: String in dir.get_files():
			if file.contains(".anim"):
				var animation_path = animations_path + animation_dir + "/" + file
				var animation: Animation = ResourceLoader.load(animation_path)
				animation_library.add_animation(file.trim_suffix(".anim"), animation)
		#drop back down a directory for the next loop
		dir.change_dir("..")
