extends Area2D

export var level = 0
onready var object = "Object"
export var room = ""

func is_input_in_area(event):
	if event.is_action_pressed("interact") and len(get_overlapping_bodies())>0 and not $DialoguePlayer/Dialogue.visible:
		return true

func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	if dialogue_player:
		dialogue_player.play(level, object, room)
