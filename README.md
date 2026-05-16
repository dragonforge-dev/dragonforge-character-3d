[![Static Badge](https://img.shields.io/badge/Godot%20Engine-4.6.1-blue?style=plastic&logo=godotengine)](https://godotengine.org/)
[![License](https://img.shields.io/github/license/dragonforge-dev/dragonforge-character-3d?logo=mit)](https://github.com/dragonforge-dev/dragonforge-character-3d/blob/main/LICENSE)
[![GitHub release badge](https://badgen.net/github/release/dragonforge-dev/dragonforge-character-3d/latest)](https://github.com/dragonforge-dev/dragonforge-character-3d/releases/latest)
[![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-character-3d)](https://img.shields.io/github/languages/code-size/dragonforge-dev/dragonforge-character-3d)

# Dragonforge Character 3D <img src="/addons/dragonforge_character_3d/assets/textures/icons/player_3d.svg" width="32" alt="Character 3D Project Icon"/>
A character controller for 3D characters.
# Version 0.6
For use with **Godot 4.6.1** and later.
## Dependencies
The following dependencies are included in the addons folder and are required for the template to function.
- [Dragonforge Camera 3D 0.3](https://github.com/dragonforge-dev/dragonforge-camera-3d)
- [Dragonforge Controller 0.14.5](https://github.com/dragonforge-dev/dragonforge-controller)
- [Dragonforge State Machine 1.1](https://github.com/dragonforge-dev/dragonforge-state-machine)
# Installation Instructions
1. Copy the `dragonforge_controller` folder from the `addons` folder into your project's `addons` folder.
2. Ignore any errors (they are appearing because the component is not yet enabled).
3. Copy the `dragonforge_camera` folder from the `addons` folder into your project's `addons` folder.
4. Copy the `dragonforge_state_machine` folder from the `addons` folder into your project's `addons` folder.
5. Copy the `dragonforge_character_3d` folder from the `addons` folder into your project's `addons` folder.
6. In your project go to **Project -> Project Settings...**
7. Select the **Plugins** tab.
8. Check the **On checkbox** under **Enabled** for **Dragonforge Controller**
9. Check the **On checkbox** under **Enabled** for **Dragonforge Camera 3D**
10. Check the **On checkbox** under **Enabled** for **Dragonforge Character 3D**
11. Press the **Close** button.
12. Go to **Project -> Reload Project**. When the project reloads, the errors in step 2 should no longer appear and the new controls for movement, jumping and camera control will be enabled. (We cannot guarantee your own errors will not still appear.) 


# Usage Instructions
There are an infinite number of 3D models you can import. We are going to try and cover some of the free options.

These instructions assume a folder structure where everything is stored in `res://assets`. Some of the scripts assuem this as well. You can move the files wherever you want - but unless you have your own folder structure, just use the recommended folders.

# KayKit Models
The [KayKit Adventurer Pack](https://kaylousberg.itch.io/kaykit-adventurers) includes four free player models. If you purchase it, you can get three more. Since KayKit has a ton of models sharing the same rigging, this means we can use the same script and approach to load any KayKit models.

## Importing the Models
The first thing to do is to import the models.

1. Download the pack.
2. Copy the `Barbarian.glb`, `Knight.glb`, `Mage.glb`, and `Rogue.glb` files to `res://assets/models/characters`.
3. Find the four `.glb` files in the **File System** area of your editor under `/assets/models/characters`.
4. Holding down the **Ctrl key** (**Command** on Mac) click on each file to select it. (You want all four `.glb` files selected, but **not** the `.png` files.)
5. Click on the **Import** tab (next to the **Scene** tab).
6. Scroll down to the **Import Script** section.
7. Click on the **Open File** button next to the **Path** text box.
8. Browse to `addons/dragonforge_character_3d_kay_kit/utilities/import/import_kay_kit_character_as_skin.gd`
9. Click the **Open** button.
10. Click the yellow **Reimport(*)** button.
11. Wait for all the files to import.

This process will create materials in `assets/materials/kay_kit_models/` for each model. They are linked to the materials in the models folder. Due to the way import scripts run, we cannot currently move and rename these files by 

##  Dealing with the Imported Textures
The import process will create folders `assets/textures/kay_kit_models/` to store all your textures (and alternate textures if you have them).

1. Drag-and-drop the textures in `/assets/models/characters` to `assets/textures/kay_kit_models/`.
2. Rename the textures to remove the duplicate name. (E.G. Rename `Barbarian_barbarian_texture.png` to `barbarian_texture.png`.)
3. Delete texture for large models. (E.G.`Barbarian_Large_barbarian_texture.png` is not used and instead uses the standard Barbarian texture.)
4. Holding down the **Ctrl key** (**Command** on Mac) click on each texture `.png` file to select it.
5. Click on the **Import** tab (next to the **Scene** tab).
6. Click on the drop-down next to **Mode** and select **Lossless** from the drop-down.
7. Click the yellow **Reimport(*)** button.

## Importing Animations
Animations are already imported to the addon. These instructions are for new animations that get created after this plugin was last updated.
The [KayKit Character Animations](https://kaylousberg.itch.io/kaykit-character-animations) are free and separate from the models. These instructions assume you want to use all the animations. If you do not, you can remove the animations you do not need.

1. Download the pack.
2. Copy medium `.glb` animation files from `Rig_Medium` to `res://addons/dragonforge_character_3d_kay_kit/assets/animations/source/medium/`.
3. Copy medium `.glb` animation files from `Rig_Large` to `res://addons/dragonforge_character_3d_kay_kit/assets/animations/source/large/`.
4. Holding down the **Ctrl key** (**Command** on Mac) click on each `.glb` animation file to select it.
5. Click on the **Import** tab (next to the **Scene** tab).
6. Scroll down to the **Import Script** section.
7. Click on the **Open File** button next to the **Path** text box.
8. Browse to `addons/dragonforge_character_3d_kay_kit/utilities/import/import_kay_kit_animations.gd`
9. Click the **Open** button.
10. Click the yellow **Reimport(*)** button.
11. Wait for all the files to import.
12. If all the folders do not show up, go to **Project -> Reload Project**.


## Creating Skins
Now that we have the models, materials, textures and animations imported, we want to utilize the editor to make local copies we can edit of our models. (Currently I don't know how to do this through code so it's a manual process.)

1. Find a model `.glb` file in **File System** (for example, `Barbarian.glb`).
2. Right-click on the file and select **New Inherited Scene**.
3. Press **Ctrl + S** (**Command + S** on Mac).
4. Navigate to `res://characters/skins`. (Create the folders if they do not exist.)
5. Press the **Save** button.

This completes the setup of the skin. It can then be used for a player, enemy, or NPC.


### Adding AnimationPlayer and AnimationTree to Skins
This can be done at any time, but is ideally done once a Skin has been added to a **CharacterBody3D**.

**NOTE:** This is included for completeness, but should not be necessary as you can directly use the KayKti Player3D scene.

1. Select the **Root Node** (i.e. for the **Barbarian** it would be named **BarbarinSkin**).
2. Press **Ctrl + A** (**Command + A** on Mac) to add a Node.
3. Type "kay" in the **Search Bar**.
4. Select the **KayKitAnimationPlayer**. (Select the **LargeKayKitAnimationPlayer** for a large model - note that selecting the wrong one may crash Godot.)
5. Press the **Create** button. (All of the imported animations will automatically be loaded.)
6. Select the **Root Node** (i.e. for the **Barbarian** it would be named **BarbarinSkin**).
7. Press **Ctrl + A** (**Command + A** on Mac) to add a Node.
8. Select the **KayKitAnimationTree**. (Select the **LargeKayKitAnimationTree** for a large model.)
9. Press the **Create** button.
10. Press **Ctrl + S** (**Command + S** on Mac).

## Importing Accessories (Weapons, Shileds, etc.)
This method of importing accessories is focused on the idea that we will have multiple copies of the same item. One for the world, and one for being equipped by characters.

Unfortunately, import scripts have some drawbacks when doing this, and a few clicks makes it possible to have more control of the created object in the end.

For this example, we will be using `axe_1handed` and `shield_round_barbarian`, which are Barbarian accessories.

1. Copy the `axe_1handed.gltf`, `axe_1handed.bin`, `shield_round_barbarian.gltf`, `shield_round_barbarian.bin`, and `barbarian_texture.png` files to `res://assets/models/accessories/barbarian/`.
2. Find the two `.gltf` file in the **File System** area of your editor under `/assets/models/accessories/barbarian/`.
3. Holding down the **Ctrl key** (**Command** on Mac) click on each file to select it. (You want both `.gltf` files selected, but **not** the `.png` file.)
4. Click on the **Import** tab (next to the **Scene** tab).
5. Scroll down to the **Import Script** section.
6. Click on the **Open File** button next to the **Path** text box.
7. Browse to `addons/dragonforge_character_3d_kay_kit/utilities/import/import_accessory.gd`
8. Click the **Open** button.
9. Click the yellow **Reimport(*)** button.
10. Wait for all the files to import.


### Creating Equippable Object Scenes
We need objects that we can equip to characters. To make this simpler, we will create objects that do not collide with the world so that they do not cause collision issues. It is possible to do this through scripting, but that is an exercise left for the reader.

For this example, we will be using `axe_1handed` and `shield_round_barbarian`, which are Barbarian accessories.

1. Find a model `.gltf` file in **File System** (for example, `/assets/models/accessories/barbarian/axe_1handed.gltf`).
2. Right-click on the file and select **New Inherited Scene**.
3. Select the **Root Node** (for example, named `Axe 1 Handed 2`).
4. Click on the node again to edit the name.
5. Change the name to remove the " 2" at hend end of the name. (for example,  `Axe 1 Handed`.)
6. Press **Ctrl + S** (**Command + S** on Mac).
7. Navigate to `res://levels/accessories/barbarian/`. (Create the folders if they do not exist.)
8. Press the **Save** button.

Repeat these steps for the `barbarian_round_shield`.

#### Axe Additional Steps
The axe needs a few modifications so that it will show up correctly in the right hand. (To have it show up correctly in the left hand, do not rotate it on the Y-axis, just move it on the Z-axis.)
1. Select the **MeshInstance3D** node. (Named `axe_1handed`.)
2. Go to the **Inspector** and open the **Transform** section under the **Node3D** header.
3. Change the **Z Position** to **0.05**
4. Change the **Y Rotation** to **180.0**
5. Press **Ctrl + S** (**Command + S** on Mac) to save the scene.

#### Shield Additional Steps


This completes the initial setup of equippable object scenes. Once you get the hang of it, the process will go very quickly.


### Creating World Object Scenes
Now we want to create world object scenes for our axe and shield. These will be used for placeable objects in the game, like in Skyrim or Fallout 4.

For this example, we will be using `axe_1handed` and `shield_round_barbarian`, which are Barbarian accessories.

1. Find a model `.gltf` file in **File System** (for example, `/assets/models/accessories/barbarian/axe_1handed.gltf`).
2. Right-click on the file and select **New Inherited Scene**.
3. Select the **Root Node** (for example, named `Axe 1 Handed 2`).
4. Click on the node again to edit the name.
5. Change the name to remove the " 2" at the end of the name and add World Object. (for example,  `Axe 1 Handed World Object`.)
6. Press **Ctrl + S** (**Command + S** on Mac).
7. Navigate to `res://levels/accessories/barbarian/`. (Create the folders if they do not exist.)
8. Press the **Save** button.
9. Right-click the **Root Node** (for example, now named `Axe 1 Handed`).
10. Select **Clear Inheritance** from the pop-up dropdown menu.
11. Press the **Clear** button on the warning that pops up. (All this warning means is that if re-import the `.gltf` file, this scene will not be affected.)
12. Right-click the **Root Node** again.
23. Select **Change Type...** from the pop-up dropdown menu.
14.  Type "rigid" in the **Search Bar** at the top of the **Change Type** window.
15. Select **RigidBody3D**.
16. Click the **Change** button.
17. Select the **MeshInstance3D** node. (for example, named `axe_1handed`.)
18. Ensure you are in **3D View**. (Click the **3D Tab** at the top of the editor window.)
19. Click the **Mesh Toolbar Button** at the top of the 3D window. (It only appears if a **MeshInstance3D** node is selected and you are in **3D View**.)
20. Select **Create Collision Shape...** from the drop-down menu that appears.
21. Select **Sibling** from the **Collision Shape Placement** dropdown. (It should be selected by default.)
22. Select **Multiple Convex** from the **Collision Shape Type** dropdown.
23. Click the **Create** button.
24. Press **Ctrl + S** (**Command + S** on Mac) to save the node changes.

Repeat these steps for the `barbarian_round_shield`. This completes the initial setup of world object scenes. Once you get the hang of it, the process will go very quickly. Now when you drop (or place) these items in a level, they will lie, or bounce around based on their collision shapes.


### Creating a Shield World Object Scene
Now we want to create a scene for our shield. For this example, we will be using `shield_round_barbarian`, which is a Barbarian accessory. (These steps are identical to the steps above for createing a **Weapon Scene**.)

1. Find a model `.gltf` file in **File System** (for example, `/assets/models/accessories/barbarian/shield_round_barbarian.gltf`).
2. Right-click on the file and select **New Inherited Scene**.
3. Select the **Root Node** (named `Shield Round Barbarian 2`).
4. Click on the node again to edit the name.
5. Change the name to `Shield Round Barbarian`. (Delete the " 2" at the end.)
6. Select the **MeshInstance3D** node. (Named `shield_round_barbarian`.)
7. Ensure you are in **3D View**. (Click the **3D Tab** at the top of the editor window.)
8. Click the **Mesh Toolbar Button** at the top of the 3D window. (It only appears if a **MeshInstance3D** node is selected and you are in **3D View**.)
9. Select **Create Collision Shape...** from the drop-down menu that appears.
10. Select **Sibling** from the **Collision Shape Placement** dropdown. (It should be selected by default.)
11. Select **Multiple Convex** from the **Collision Shape Type** dropdown.
12. Click the **Create** button.
13. Press **Ctrl + S** (**Command + S** on Mac).
14. Navigate to `res://characters/accessories/barbarian/`. (Create the folders if they do not exist.)
15. Press the **Save** button.

This completes the intial setup of the shield scene. Once you get the hang of it, the process will go very quickly. Now when you drop it in a game, it will bounce around based on its collision shape.


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

# Resources
These instructions were written in part by using advice from the video [Using KayKit Characters in Godot (Detailed Version)](https://www.youtube.com/watch?v=4p7QaOd8SHE) by Kay Lousberg.
