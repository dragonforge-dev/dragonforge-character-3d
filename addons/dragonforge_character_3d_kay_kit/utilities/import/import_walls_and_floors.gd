@tool
## Import Script for walls and floors, giving them trimesh collision meshes
extends EditorScenePostImport


func _post_import(scene):
	iterate(scene)
	return scene


func iterate(node):
	if node != null:
		if node is MeshInstance3D:
			node.create_trimesh_collision()
		for child in node.get_children():
			iterate(child)
