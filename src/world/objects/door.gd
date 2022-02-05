extends "res://src/world/objects/objects.gd"


export var is_door_locked = false
export(Vector2) var next_pos
export(String, FILE) var next_room
export(String) var door_name

func _ready():
	object = door_name
	$DialoguePlayer/Dialogue.visible = false

func _input(event):
	if is_input_in_area(event):
		if is_door_locked:
			.find_and_use_dialogue()
		else:
			SceneChanger.change_scene(next_room, 'fade', next_pos)
