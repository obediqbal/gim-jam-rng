extends "res://src/world/objects/objects.gd"


func _ready():
	object = "alice_novel"
	$DialoguePlayer/Dialogue.visible = false
