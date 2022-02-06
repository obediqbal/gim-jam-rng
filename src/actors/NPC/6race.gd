extends "NPC.gd"


func _ready():
	npc = "Grace"
	$DialoguePlayer/Dialogue.visible = false
	if level == 3:
		$DistortAnimation.visible = false
