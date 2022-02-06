extends "res://src/world/objects/objects.gd"


export var is_door_locked = false
export(Vector2) var next_pos
export(String, FILE) var next_room
export(String, FILE) var next_scene
export(String) var door_name
export(String) var door_direction

func _ready():
	object = door_name
	is_a_door = true
	$DialoguePlayer/Dialogue.visible = false

#func _input(event):
#	if is_input_in_area(event):
#		if is_door_locked:
#			.find_and_use_dialogue()
#		else:
#			SceneChanger.change_scene(next_room, 'fade', next_pos, door_name!="door_hall")


func _process(delta):
	turn_off_arrow()
	if not mouse_here or len(get_overlapping_bodies())==0:
		return
	else:
		turn_on_arrow(door_direction)
		if Input.is_action_just_pressed("click") and not $DialoguePlayer/Dialogue.visible:
			if is_door_locked:
				.find_and_use_dialogue()
			else:
				if door_name == "door_living" and not Global.living_visited_0:
					SceneChanger.change_scene(next_scene, 'fade', null, door_name!="door_hall")			
				elif door_name == "door_dining" and not Global.dining_visited_0:
					SceneChanger.change_scene(next_scene, 'fade', null, door_name!="door_hall")		
				else:
					SceneChanger.change_scene(next_room, 'fade', next_pos, door_name!="door_hall")


func turn_on_arrow(direction):
	if direction == "up":
		$ArrowUp.visible = true
	elif direction == "right":
		$ArrowRight.visible = true
	elif direction == "down":
		$ArrowDown.visible = true
	elif direction == "left":
		$ArrowLeft.visible = true

func turn_off_arrow():
	$ArrowUp.visible = false
	$ArrowRight.visible = false
	$ArrowDown.visible = false
	$ArrowLeft.visible = false
	
