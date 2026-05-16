@tool
# Imports Animations
extends EditorScenePostImport

#Filepaths
const ANIMATIONS_PATH = "res://addons/dragonforge_character_3d_kay_kit/assets/animations/"
const LOOPMODE = ["LOOP_NONE", "[b][color=green]LOOP_LINEAR[/color][/b]", "[b][color=orange]LOOP_PINGPONG[/color][/b]"]

enum LoopMode { LOOP_NONE, LOOP_LINEAR, LOOP_PINGPONG }
var scene_name: StringName = ""
var animation_type: String = ""
var prefix: String = ""
var owner_scene


# Import script for rig to set up everything so little editing is needed once the character is
# instantiated.
func _post_import(scene):
	owner_scene = scene
	scene_name = scene.name
	if scene_name.contains("Medium"):
		animation_type = "medium/"
		prefix = "Rig_Medium_"
	elif scene_name.contains("Large"):
		animation_type = "large/"
		prefix = "Rig_Large_"
	print_rich("\n[b][color=red]Begin Post-import[/color] -> [color=purple]%s[/color] as [color=green]%s[/color][/b]" % [scene_name, scene.get_class()])
	print_rich("[b]Time/Date Stamp: %s[/b]\n" % [Time.get_datetime_string_from_system(false, true)])
	prepare(scene)
	# This code ensures the animations sho up in FileSystem
	var fs: EditorFileSystem = EditorInterface.get_resource_filesystem()
	fs.scan()

	return scene


func prepare(node: Node) -> void:
	if node is AnimationPlayer:
		for animation_name: String in node.get_animation_list():
			if animation_name.contains("Idle") or animation_name.contains("ing"):
				node.get_animation(animation_name).set_loop_mode(LoopMode.LOOP_LINEAR)
			print_rich("Post-import: [b]%s[/b] -> [b]%s[/b]" % [animation_name, LOOPMODE[node.get_animation(animation_name).get_loop_mode()]])
			#We only need the T-Pose animation name once, in General.
			if animation_name.contains("T-Pose") and not scene_name.contains("General"):
				continue
			var animation: Animation = node.get_animation(animation_name)
			var animation_path: String = ANIMATIONS_PATH + animation_type + str(owner_scene.name).trim_prefix(prefix).to_snake_case() + "/" + animation_name.to_snake_case() + ".anim"
			ensure_path_exists(animation_path)
			ResourceSaver.save(animation, animation_path)
	
	for subnode in node.get_children():
		prepare(subnode)


#Checks to make sure the path exists, and if not, creates the requisite folders.
func ensure_path_exists(path: String) -> void:
	var directory: String = path.get_base_dir()
	if DirAccess.dir_exists_absolute(directory):
		return
	else:
		DirAccess.make_dir_recursive_absolute(directory)
