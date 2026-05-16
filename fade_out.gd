extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade(self, 1.0, 3.0)


## Fades all MeshInstance3D child nodes recursively to fade.
## Setting fade_goal = 0.0 will fade the node out.
## Setting fade_goal = 1.0 will fade the node in.
## You MUST set the Mesh's Material's transparency to Alpha
## for this code to work.
func fade(node: Node, fade_goal: float, time: float) -> void:
	if node is MeshInstance3D:
		var material: Material = node.get_active_material(0)
		var tween := create_tween()
		tween.tween_property(material, "albedo_color:a", fade_goal, time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	
	for subnode in node.get_children():
		fade(subnode, fade_goal, time)
