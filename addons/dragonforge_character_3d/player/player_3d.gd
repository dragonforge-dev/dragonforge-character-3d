class_name Player3D extends Character3D


@export var rig: Node3D
## The speed at which the player turns.
@export var animation_decay: float = 20.0


@onready var cameras: Cameras = $Cameras


var direction := Vector3.ZERO


func _ready() -> void:
	for node in rig.get_children():
		if node is AnimationPlayer:
			animation_tree.anim_player = node.get_path()


func _physics_process(delta: float) -> void:
	super(delta)

	if velocity.length() > 1.0 and direction != Vector3.ZERO:
		look_toward(direction, delta)


func look_toward(direction: Vector3, delta: float) -> void:
	var target := rig.global_transform.looking_at(rig.global_position + direction, Vector3.UP)
	rig.global_transform = rig.global_transform.interpolate_with(target, 1.0 - exp(-animation_decay * delta))
