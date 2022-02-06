extends "res://src/world/objects/objects.gd"


func _ready():
	object = "playing_card"
	no_hover = true
	$DialoguePlayer/Dialogue.visible = false
