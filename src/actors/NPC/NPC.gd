extends Area2D

export var level = 0
onready var npc = "NPC"
onready var hover_sprite = get_node('hover/OnHover')
onready var sprite = $Sprite
onready var mouse_here = false
export var room = ""

#func _input(event):
#	if event.is_action_pressed("interact") and len(get_overlapping_bodies())>0 and not $DialoguePlayer/Dialogue.visible:
#		find_and_use_dialogue()
		
		
func _process(delta):
	if not mouse_here or len(get_overlapping_bodies())==0:
		if not $DialoguePlayer/Dialogue.visible:
			sprite.visible = true
			hover_sprite.visible = false
	else:
		sprite.visible = false
		hover_sprite.visible = true
		if Input.is_action_just_pressed("click") and not $DialoguePlayer/Dialogue.visible:
			find_and_use_dialogue()


func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	if dialogue_player:
		dialogue_player.play(level, npc, room)


func _on_hover_mouse_entered():
	mouse_here = true


func _on_hover_mouse_exited():
	mouse_here = false
