extends CharacterBody3D

# Tile size in Godot meters
const TILE_SIZE = 2.0 # constants should always have UPPERCASE_NAMES

@export_category("Movement")
@export var walk_speed: float = 0.2
@export var sprint_speed: float = 0.45

var speed: float = walk_speed
var movement_remaining: float = 0.0
var direction: Vector3 = Vector3.ZERO
# Animation variables
var facing : String


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir: Vector2 = Vector2.ZERO
	if movement_remaining == 0.0:
		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		if movement_remaining == 0.0:
			movement_remaining = TILE_SIZE
			#Facing
			match direction:
				Vector3.LEFT:
					facing = "left"
				Vector3.RIGHT:
					facing = "left"
				Vector3.FORWARD:
					facing = "up"
				Vector3.BACK:
					facing = "down"
		if movement_remaining > 0.0:
			movement_remaining -= delta * speed * TILE_SIZE
			velocity.x = direction.x * speed * TILE_SIZE
			velocity.z = direction.z * speed * TILE_SIZE
		else:
			movement_remaining = 0.0
			direction = Vector3.ZERO
			velocity = Vector3.ZERO
	
		print(movement_remaining)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and movement_remaining <= 0.0:
		if speed == walk_speed:
			print("Sprint toggled")
			speed = sprint_speed
		else:
			print("Walk toggled")
			speed = walk_speed
