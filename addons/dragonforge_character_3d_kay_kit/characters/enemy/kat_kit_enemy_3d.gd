@icon("res://addons/dragonforge_character_3d/assets/textures/icons/player_3d.svg")
## Enemy class for KayKit models.
class_name KayKitEnemy3D extends KayKitCharacter3D

## The speed at which the player turns.
@export var turn_speed: float = 20.0

var direction := Vector3.ZERO
var rig: Node3D

func _ready() -> void:
	rig = skin.get_child(0) #Assumes the rig is the first node in the skin.


func _physics_process(delta: float) -> void:
	if direction:
		look_toward(direction, delta)
	move_and_slide()


#Move this to the rig code?
func look_toward(direction: Vector3, delta: float) -> void:
	var target := rig.global_transform.looking_at(rig.global_position + direction, Vector3.UP)
	rig.global_transform = rig.global_transform.interpolate_with(target, 1.0 - exp(-turn_speed * delta))


func look_at_target_smooth(target: Node3D, delta: float) -> void:
	var direction_to_target = (target.global_position - rig.global_position).normalized()
	direction_to_target.y = 0.0
	look_toward(direction_to_target, delta)


# Returns true if the environment is not blocking the target from sight (usually the player).
func can_see(target: Node3D) -> bool:
	var space_state = get_world_3d().direct_space_state
	var ray = PhysicsRayQueryParameters3D.create(position, target.position, GameConstants.ENVIRONMENT_LAYER + GameConstants.ENEMY_LAYER)
	var sight_check = space_state.intersect_ray(ray)
	if sight_check:
		return false
	else:
		return true
