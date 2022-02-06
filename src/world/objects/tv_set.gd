extends "res://src/world/objects/objects.gd"


func _ready():
	object = "tv_set"
	$DialoguePlayer/Dialogue.visible = false


func _process(delta):
	if not mouse_here or len(get_overlapping_bodies())==0:
		if not $DialoguePlayer/Dialogue.visible and not no_hover:
			$TVOff.visible = true
			hover_sprite.visible = false
	else:
		if not no_hover:
			$TVOff.visible = false
			hover_sprite.visible = true
		if Input.is_action_just_pressed("click") and not $DialoguePlayer/Dialogue.visible:
			find_and_use_dialogue()
