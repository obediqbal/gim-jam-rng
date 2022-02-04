extends "res://src/dialogues/DialoguePlayer.gd"


func next_line():
	.next_line()
	if current_dialogue_id >= len(current_parent):
		SceneChanger.change_scene("res://src/level/0/porch.tscn", "fade", Vector2(500,300))
