[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.5.stable-blue?style=plastic&logo=godotengine)](https://godotengine.org/)

# Dragonforge Character 3D <img src="/addons/dragonforge_character_3d/assets/textures/icons/player_3d.svg" width="32" alt="Character 3D Project Icon"/>
A character controller for 3D characters.
# Version 0.5.1
For use with **Godot 4.5.stable** and later.
## Dependencies
The following dependencies are included in the addons folder and are required for the template to function.
- [Dragonforge Camera 3D 0.2.2](https://github.com/dragonforge-dev/dragonforge-camera-3d)
- [Dragonforge Controller 0.12.1](https://github.com/dragonforge-dev/dragonforge-controller)
- [Dragonforge State Machine 0.5](https://github.com/dragonforge-dev/dragonforge-state-machine)
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


# Usage Instructions
## Importing Models
There are an infinite number of 3D models you can import. We are going to try and cover some of the free options.
### KayKit Models
The [KayKit Adventurer Pack](https://kaylousberg.itch.io/kaykit-adventurers) includes four free player models. If you purchase it, you can get two more. Since KayKit has a ton of models sharing the same rigging, this means we can use the same script and approach to load any KayKit models.

## Importing the Models
The first thing to do is to import the models. You can do this without a script, but this plugin has a script that handles a number of tasks, including: automatically looping all loopable animations; deleting custom **BoneAttachmentNode3D** nodes and creating generically named ones; moving all the equipment out of the character models but preserving them so you can copy them to their own nodes; rotating the model 180 degrees so it faces the forward (-Z axis); and, simplifies the names of the **MeshInstance3D** nodes.

1. Download the pack.
2. Copy the `Barbarian.glb`, `Knight.glb`, `Mage.glb`, and `Rogue.glb` files to your project.
3. Find the four `.glb` files in the **FileSystem** area of your editor.
4. Holding down the Ctrl key (Command on Mac) click on each file to select it. (You want all four `.glb` files selected, but **not** the `.png` files.)
5. Click on the **Import** tab (next to the **Scene** tab).
6. Scroll down to the **Import Script** section.
7. Click on the **Open File** button next to the **Path** text box.
8. Browse to `res://addons/dragonforge_character_3d/utilities/import/import_kay_kit_character_as_skin.gd`
9. Click the **Open** button.
10. Click the yellow **Reimport(*)** button.
11. Wait for all the files to import.

## Creating the Skins
Now that we have the models imported, we want to utilize the editor to make local copies we can edit of our models. Currently I don't know how to do this through code so it's a manual process.
1. Create a new **Scene** with a **Node3D** as the root.
2. Rename the **Node3D** node to **Workspace** an save it. (This scene is a temporary workspace but we don't want to lose anything to a crash while we are working.)
3. Drag-and-drop the four `.glb` files from FileSystem on top of the **Node3D** node. (You should have four **Node3D** nodes named `BarbarianSkin` etc. under the first node.)
4. Right-click on the **BarbarianSkin** node and select **Make Local** from the pop-up menu. (The **Open in Editor** button will disappear.)
5. Expand the **BarbarianSkin** node.
6. Scroll down and find all the **MeshInstance3D** nodes after the **AnimationPlayer**.
7. Move these nodes to the **Workspace** root node so they are no longer part of the **BarbarianSkin** node.
8. Right-click on the **BarbarianSkin** node and select **Save Branch as Scene** from the pop-up menu.
9. Select a location to save it. (I recommend `res://assets/skins/`, but whatever works for you is fine.)
10. Press the **Save** button. (The **Open in Editor** button will re-appear once you save the file.)
11. Repeat steps 3 to 10 for the other three models.
**NOTE:** Once the skins are created this way, re-importing the model will have no effect on it.

## Creating a Shield
Let's create a shield. We've created a **Shield** class and a **ShieldResource** class to get things started.
1. Find the **Barbarian_Round_Shield** node under our **Workspace** node.
2. Right-click the **Barbarian_Round_Shield** node and select **Copy**.
3. Create a new scene.
4. Press the **Other Node** button in the scene tree under the **Create Root Node** heading.
5. Type "shield" in the search bar.
6. Select the **Shield** node.
7. Press the **Create** button.
8. Right-click on the new **Shield** node and select **Paste**.
9. Right-click the Shield node and rename it. (**BarbarianRoundShield** is a good name.)
10. Save the node. (`res://equipment/shields` is a good location.)

### Adding a CollisionShape3D to the Shield
While it's not necessary to make the shield functionally work if it adds stats of some sort, if you do want it to work you can take the following steps.
1. Make sure you are in **3D View** by clicking the **3D** button at the top middle of the Godot editor.
2. Select the **Barbarian_Round_Shield** node (which is a **MeshInstance3D** node.)
3. Click on the **Mesh** button that appears in the toolbar.
4. Select **Create Collision Shape...** from the dropdown menu that appears.
5. In the pop-up window under **Collision Shape Placement** select **Static Body Child**.
6. In the pop-up window under **Collision Shape Type** select **Trimesh**.
7. Select the **StaticBody3D** node.
8. In the inspector, under **CollisionObject3D -> Collision -> Layer** select the layers you want to be blocked by this node. (See below.)

Selecting the layers you want to be affected determines what the shield blocks. Unless you're having issues with it colliding with the player model, just have it collide with everything. (If it does not collide with the environment, it will fall through the ground when dropped.)

### Adding Stats to the Shield
1. With the renamed **BarbarianRoundShield** selected, look at the **Inspector** on the right.
2. Click the drop-down arrow next to the **Resource** field and select **New Shield Resource**
3. Click on the **ShieldResource** that appears to expand it.
4. Change the **Defense** value to `0.5`.


## Creating the Equipment
Now that we have skins, we want to create scenes for all the individual items. Later on you'll want to add scripts to them but for now we are focusing on appearance.
1. Find the **Barbarian_Hat** node under our **Workspace** node.
2. Right-click the **Barbarian_Hat** node and select **Save Branch as Scene**.
3. Select a location to save it. (I recommend `res://assets/accessories/`, but whatever works for you is fine.)
4. Scroll back up to the **BarbarianSkin** node.
5. Click the **Open in Editor** button to the right of the **BarbarianSkin** node. (It looks like the movie slates they use in movies to start a scene.)
6. Select the **HeadSlot** node.
7. Right click on the **HeadSlot** node and select **Instantiate Child Scene...** from the pop-up menu.
8. Search for `barbarian` in the window that pops up.
9. Select the `barbarian_hat.tscn` file.
10. Click on the **3D** tab at the very top of the screen. (You will see the Barbarian is wearing the hat and it is in the right position on the model.)

You can repeat these steps for any items you want to keep. Alternately, you can just copy and paste the objects back in place on the model if you like in the appropriate slot. The import script was made to make it easier to swap out characters and mix/match equipment. So there's a little more work to re-equip the characters than just a straight import. However having all the models already loaded means you don't have to search in the `Assets` folder of the zipfile for as many things.


## Using the Existing Player  <img src="/addons/dragonforge_character_3d/assets/textures/icons/player_3d.svg" width="32" alt="Player Icon"/>
1. Add the `res://addons/dragonforge_character_3d/player/player_3d.tscn` script to your **CharacterBody3D** node. (It is recommended that if you want to make any changes to the file, to inherit from it.)


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
