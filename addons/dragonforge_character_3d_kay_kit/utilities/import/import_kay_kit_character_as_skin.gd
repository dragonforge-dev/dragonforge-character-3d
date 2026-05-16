@tool
extends EditorScenePostImport

enum LoopMode { LOOP_NONE, LOOP_LINEAR, LOOP_PINGPONG }
const LOOPMODE = ["LOOP_NONE", "[b][color=green]LOOP_LINEAR[/color][/b]", "[b][color=orange]LOOP_PINGPONG[/color][/b]"]
var owner_scene
var slots: Dictionary = {
	"HeadSlot" : "head",
	"RightHandSlot": "handslot.r",
	"LeftHandSlot": "handslot.l",
	"BackSlot": "chest"
}


# Import script for rig to set up everything so little editing is needed once the character is
# instantiated.
func _post_import(scene):
	owner_scene = scene
	print_rich("\n[b][color=red]Begin Post-import[/color] -> [color=purple]%s[/color] as [color=green]%s[/color][/b]" % [scene.name + "Skin", scene.get_class()])
	print_rich("[b]Time/Date Stamp: %s[/b]\n" % [Time.get_datetime_string_from_system(false, true)])
	prepare(scene)
	enhance(scene)
	scene.name = scene.name + "Skin"
	print_rich("\n[b][color=red]NOTE:[/color][/b] Ignore any [color=salmon]ERROR[/color] messages directly after this line. This happens due to the way we are linking the texture externally. [b]You can copy the texture to another folder and/or rename it as you please now that import is complete - as it is not possible to do so during the import process.[/b]")
	return scene


func prepare(node: Node) -> void:
	# Rotating the model to face the other direction so it moves in the correct direction when animated.
	if node is Skeleton3D:
		node.rotate_y(deg_to_rad(-180.0))
		print_rich("Post-import: [b]Rotated [color=green]%s[/color] [color=yellow]-180 degrees[/color][/b] on the [b][color=green]y-axis[/color][/b]" % [node.get_class()])
	
	if node is MeshInstance3D:
		# We want to rename all the meshes to have more generic names.
		node.name = node.name.trim_prefix(owner_scene.name + "_")
		print_rich("Post-import: [b]Visibile [color=green]%s[/color] [color=yellow]%s[/color][/b] -> [color=yellow][b]%s[/b][/color]" % [node.get_class(), node.name, get_color_string(node.visible)])

		var mesh: Mesh = node.mesh
		for index in mesh.get_surface_count():
			var material: StandardMaterial3D = mesh.surface_get_material(index)
			# We are using the MATERIALS_PATH and then a "kay_kit_models/" directory. Next we take
			# the scene name and convert it to a string, and then use rslpit() to get rid of any
			# underscore suffixes off for Barbarian or Skeleton models (so they use the same
			# textures.) Then we convert the whole thing to snake_case to avoid export errors down
			# the line, and add on the .material file extension.
			var material_path: String = GameConstants.MATERIALS_PATH + "kay_kit_models/" + str(owner_scene.name).rsplit("_", true, 1)[0].to_snake_case() + ".material"
			if ResourceLoader.exists(material_path):
				var saved_material: StandardMaterial3D = ResourceLoader.load(material_path)
				print("Assigning saved material")
				mesh.surface_set_material(index, saved_material)
			else:
				# This code turns the embedded texture into an externally linked texture.
				var fs: EditorFileSystem = EditorInterface.get_resource_filesystem()
				fs.scan()
				#Creates a folder that can be used to copy the texture into manually.
				var texture_path: String = GameConstants.TEXTURES_PATH + "kay_kit_models/" + str(owner_scene.name).to_snake_case() + "/" + str(owner_scene.name).to_snake_case() + "_texture.png"
				ensure_path_exists(texture_path)
				
				#Create material
				ensure_path_exists(material_path)
				ResourceSaver.save(material, material_path)
				print("Material saved to %s" % [material_path])
				var saved_material: StandardMaterial3D = ResourceLoader.load(material_path)
				mesh.surface_set_material(index, saved_material)
	
	# Recursively call this function on any subnodes that exist.
	for subnode in node.get_children():
		prepare(subnode)


func enhance(node: Node) -> void:
	#Add slots for head, hands and chest (which is where the capes go).
	if node is Skeleton3D:
		for slot in slots:
			var bone_attachment_3d: BoneAttachment3D = BoneAttachment3D.new()
			node.add_child(bone_attachment_3d)
			bone_attachment_3d.owner = owner_scene
			bone_attachment_3d.name = slot
			bone_attachment_3d.bone_name = slots[slot]
			print_rich("Post-import: [b]Added [color=green]%s[/color] -> Slot: [color=yellow]%s[/color][/b]" % [slot, slots[slot]])
	# Recursively call this function on any subnodes that exist.
	for subnode in node.get_children():
		enhance(subnode)


#Checks to make sure the path exists, and if not, creates the requisite folders.
func ensure_path_exists(path: String) -> void:
	var directory: String = path.get_base_dir()
	if DirAccess.dir_exists_absolute(directory):
		return
	else:
		DirAccess.make_dir_recursive_absolute(directory)


# Return rich text color string for true (green)/red (false).
func get_color_string(value: bool):
	if value:
		return "[color=green]true[/color]"
	else:
		return "[color=red]false[/color]"
