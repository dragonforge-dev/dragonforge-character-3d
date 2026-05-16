@tool
## Creates a trimesh collision so that the accessory can be dropped on the ground.
## Uses the appropriate material, and if not available, creates one.
extends EditorScenePostImport

var owner_scene


func _post_import(scene):
	iterate(scene)
	scene.name = scene.name.capitalize()
	return scene


func iterate(node) -> void:
	if node != null:
		if node is MeshInstance3D:
			var mesh: Mesh = node.mesh
			for index in mesh.get_surface_count():
				var material: StandardMaterial3D = mesh.surface_get_material(index)
				# We are using the MATERIALS_PATH and then a "kay_kit_models/" directory. Next we take
				# the scene name and convert it to a string, and then use rslpit() to get rid of any
				# underscore suffixes off for Barbarian or Skeleton models (so they use the same
				# textures.) Then we convert the whole thing to snake_case to avoid export errors down
				# the line, and add on the .material file extension.
				var material_path: String = GameConstants.MATERIALS_PATH + "kay_kit_models/" + material.resource_name.to_snake_case() + ".material"
				if ResourceLoader.exists(material_path):
					var saved_material: StandardMaterial3D = ResourceLoader.load(material_path)
					print("Assigning saved material")
					mesh.surface_set_material(index, saved_material)
				else:
					# This code turns the embedded texture into an externally linked texture.
					var fs: EditorFileSystem = EditorInterface.get_resource_filesystem()
					fs.scan()
					#Creates a folder that can be used to copy the texture into manually.
					var texture_path: String = GameConstants.TEXTURES_PATH + "kay_kit_models/" + str(owner_scene.name).to_snake_case() + "/" + material.resource_name.to_snake_case() + "_texture.png"
					ensure_path_exists(texture_path)
					
					#Create material
					ensure_path_exists(material_path)
					ResourceSaver.save(material, material_path)
					print("Material saved to %s" % [material_path])
					var saved_material: StandardMaterial3D = ResourceLoader.load(material_path)
					mesh.surface_set_material(index, saved_material)
		for subnode in node.get_children():
			iterate(subnode)


#Checks to make sure the path exists, and if not, creates the requisite folders.
func ensure_path_exists(path: String) -> void:
	var directory: String = path.get_base_dir()
	if DirAccess.dir_exists_absolute(directory):
		return
	else:
		DirAccess.make_dir_recursive_absolute(directory)
