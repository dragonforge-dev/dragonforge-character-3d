[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.5.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
# Dragonforge Character 3D
A character controller for 3D characters.
# Version 0.4
For use with **Godot 4.5.stable** and later.
## Dependencies
The following dependencies are included in the addons folder and are required for the template to function.
- [Dragonforge Camera 3D 0.2](https://github.com/dragonforge-dev/dragonforge-camera-3d)
- [Dragonforge Controller 0.12](https://github.com/dragonforge-dev/dragonforge-controller)
- [Dragonforge State Machine 0.3](https://github.com/dragonforge-dev/dragonforge-state-machine)
# Installation Instructions
1. Copy the `dragonforge_controller` folder from the `addons` folder into your project's `addons` folder.
2. Ignore the following errors (they are appearing because the component is not yet enabled):
  * ERROR: res://addons/dragonforge_controller/controller.gd:54 - Parse Error: Identifier "Keyboard" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:56 - Parse Error: Identifier "Mouse" not declared in the current scope.
  * ERROR: res://addons/dragonforge_controller/controller.gd:59 - Parse Error: Identifier "Gamepad" not declared in the current scope.
  * ERROR: modules/gdscript/gdscript.cpp:3022 - Failed to load script "res://addons/dragonforge_controller/controller.gd" with error "Parse error".
3. Copy the `dragonforge_camera` folder from the `addons` folder into your project's `addons` folder.
4. Copy the `dragonforge_state_machine` folder from the `addons` folder into your project's `addons` folder.
5. Copy the `dragonforge_character_3d` folder from the `addons` folder into your project's `addons` folder.
6. In your project go to **Project -> Project Settings...**
7. Select the **Plugins** tab.
8. Check the **On checkbox** under **Enabled** for **Dragonforge Controller**
9. Check the **On checkbox** under **Enabled** for **Dragonforge Character 3D**
10. Press the **Close** button.
11. Go to **Project -> Reload Project**. When the project reloads, the errors in step 2 should no longer appear and the new controls for movement, jumping and camera control will be enabled. (We cannot guarantee your own errors will not still appear.) 


# Usage
## Using the Existing Player
1. Copy the `res://addons/dragonforge_character_3d/player/player_3d.tscn` file to your project.
2. Rename the file to `player.tscn`
3. If you make any changes to the file, inherit from it.


## Making Your Own Player
1. On your **CharacterBody3D** node click **+ Add Child Node...** and select a **Cameras** node.
2. On your **Cameras** node click **+ Add Child Node...** and add as many **Camera3D** nodes as you like. Configure them however you like. The player will be able to rotate through them at will.
## First-Person View Camera
1. If you haven't already, on your **CharacterBody3D** node click **+ Add Child Node...** and select a **Cameras** node.
2. On your **Cameras** node click **+ Add Child Node...** and add a **CameraMount3D** node.
3. Change the **Upwards Rotation Limit** to **-15**.
4. Change the **Downwards Rotation Limit** to **40**.
5. Check the **First Person** box.
6. Add the following code to your **CharacterBody3D**:

```
class_name Player extends Character


## Your character model
@export var rig: Node3D
## The speed at which the player turns.
@export var animation_decay: float = 20.0
##
@export var speed = 5.0


#A reference to your Cameras object
@onready var cameras: Cameras = $Cameras


var direction := Vector3.ZERO


func _physics_process(delta: float) -> void:
	direction = get_input_direction()
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	if velocity.length() > 1.0 and direction != Vector3.ZERO:
		look_toward_direction(delta)
	
	move_and_slide()
	

func get_input_direction() -> Vector3:
	var camera = cameras.active_camera
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var input_vector := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if camera is CameraMount3D:
		return camera.horizontal_pivot.global_transform.basis * input_vector
	elif camera.rotation.y != 0.0:
		return input_vector.rotated(Vector3.UP, camera.rotation.y).normalized()
	else:
		return transform.basis * input_vector


func look_toward_direction(delta: float) -> void:
	var target := rig.global_transform.looking_at(rig.global_position + direction, Vector3.UP)
	rig.global_transform = rig.global_transform.interpolate_with(target, 1.0 - exp(-animation_decay * delta))
```
