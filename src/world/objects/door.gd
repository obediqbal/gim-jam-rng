extends "res://src/world/objects/objects.gd"


export var is_door_locked = false
export(String, FILE) var next_room

func _ready():
	object = "door"
	$DialoguePlayer/Dialogue.visible = false

func _input(event):
	if is_input_in_area(event):
		if is_door_locked:
			.find_and_use_dialogue()
		else:
			SceneChanger.change_scene(next_room, 'fade')
		
	
