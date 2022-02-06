extends "res://src/world/objects/objects.gd"


export var is_door_locked = false
export(Vector2) var next_pos
export(String, FILE) var next_room
export(String) var door_name

func _ready():
	object = door_name
	is_a_door = true
	$DialoguePlayer/Dialogue.visible = false

func _input(event):
	if is_input_in_area(event):
		if is_door_locked:
			.find_and_use_dialogue()
		else:
			SceneChanger.change_scene(next_room, 'fade', next_pos, door_name!="door_hall")


func _process(delta):
	if not mouse_here or len(get_overlapping_bodies())==0:
		pass
	else:
		if Input.is_action_just_pressed("click") and not $DialoguePlayer/Dialogue.visible:
			if is_door_locked:
				.find_and_use_dialogue()
			else:
				SceneChanger.change_scene(next_room, 'fade', next_pos, door_name!="door_hall")
