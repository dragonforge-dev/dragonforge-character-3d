class_name PlayerJumpState extends PlayerState


#TODO: Move to jump ability
## Jump Velocity defaults to zero unless the JumpVelocity stat is assigned,
## then that number is used.
var jump_velocity: float


@onready var timer: Timer = $Timer


var can_land = false
var landing = false


func _ready() -> void:
	timer.timeout.connect(_on_timeout)


func _activate_state() -> void:
	super()
	set_process(true)
	set_physics_process(true)
	jump_velocity = character.get_stat_value(StatResource.Type.JumpVelocity)


func _on_timeout():
	print("Timeout")
	can_land = true


# If the player presses the Jump action, switch to the Jump state.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") and character.is_on_floor():
		switch_state()
		character.velocity.y = jump_velocity


# Process the jump every frame and trigger the landing when we land.
func _physics_process(_delta: float) -> void:
	if character.is_on_floor() and can_land and not landing:
		print("Land")
		land()
	character.move_and_slide()


func land():
	landing = true
	character.animation_state.travel("Jump_Land")


# Starts the jump animation, and turns off the ability to transition to
# another state mid-jump.
func _enter_state() -> void:
	super()
	character.animation_tree.connect("animation_finished", _on_animation_finished)
	character.animation_state.travel("Jump_Start")
	can_transition = false
	timer.start()
	can_land = false
	landing = false


func _exit_state() -> void:
	super()
	character.animation_tree.disconnect("animation_finished", _on_animation_finished)


# Allows state transition only after the initial Jump_Start animation has been called. This is
# because otherwise the landing animation is called because the first physics frame this class runs
# is from the floor and so is_on_floor() is still true.
func _on_animation_finished(animation_name: String) -> void:
	match animation_name:
		"Jump_Land":
			can_transition = true
