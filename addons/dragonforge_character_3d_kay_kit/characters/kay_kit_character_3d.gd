@icon("res://addons/dragonforge_character_3d/assets/textures/icons/character_3d.svg")
## Base character class for KayKit Models - used for Players, NPCs, and Enemies.
class_name KayKitCharacter3D extends CharacterBody3D


## The character skin to use.
@export var skin: Node3D
@export var animation_tree: KayKitAnimationTree
#Movement export variables
@export_category("Movement")
## The character's base walk speed.
@export var base_speed: float = 6.0

### The character's run/chase speed.
#@export var run_speed: float = 6.0
### The character's speed while blocking/defending.
#@export var defend_speed: float = 2.0

var speed = base_speed

#Combat Variables
#@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D


## Applies gravity to the character. The gravity multiplier can be used when jumping or falling
## to make the character rise slower or faster, or to fall like a rock or a feather.
## This function uses get_gravity() so that it is affected by Area3D nodes that
## might also apply a localized gravity.
func apply_gravity(delta: float, gravity_multiplier: float = 1.0) -> void:
	velocity += get_gravity() * delta * gravity_multiplier


func set_move_state(move_state: GameConstants.MoveState) -> void:
	animation_tree.set_move_state(move_state)


func trigger_animation(animation: GameConstants.AnimationType) -> void:
	animation_tree.trigger_animation(animation)


func block_toggle(forward: bool) -> void:
	var tween = create_tween()
	tween.tween_method(animation_tree.block_change, 1.0 - float(forward), float(forward), 0.25)
