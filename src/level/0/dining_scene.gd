extends Node2D

var level = 1

func _ready():
	$Control/AnimationPlayer.play('black')
	$DialoguePlayer/Dialogue.visible = false
	Global.dining_visited_0 = true


func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	if dialogue_player:
		dialogue_player.play(level, "scene", "room_dining")
