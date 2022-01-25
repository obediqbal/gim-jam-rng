extends Area2D

export var level = 0
onready var npc = "NPC"
export var room = ""


func _input(event):
	if event.is_action_pressed("interact") and len(get_overlapping_bodies())>0 and not $DialoguePlayer/Dialogue.visible:
		find_and_use_dialogue()
		
		
func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	if dialogue_player:
		dialogue_player.play(level, npc, room)
