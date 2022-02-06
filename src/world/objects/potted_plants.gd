extends "res://src/world/objects/objects.gd"


func _ready():
	object = "potted_plants"
	no_hover = true
	$DialoguePlayer/Dialogue.visible = false
