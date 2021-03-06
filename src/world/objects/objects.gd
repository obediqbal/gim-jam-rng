extends Area2D

export var level = 0
onready var object = "Object"
onready var hover_sprite = get_node('hover/OnHover')
onready var sprite = $Sprite
onready var mouse_here = false
export var room = ""
onready var is_a_door = false
onready var no_hover = false

func is_input_in_area(event):
	if event.is_action_pressed("interact") and len(get_overlapping_bodies())>0 and not $DialoguePlayer/Dialogue.visible:
		return true


func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("DialoguePlayer")
	if dialogue_player:
		dialogue_player.play(level, object, room)


func _process(delta):
	if is_a_door or object == "tv_set":
		return
	if not mouse_here or len(get_overlapping_bodies())==0:
		if not $DialoguePlayer/Dialogue.visible and not no_hover:
			sprite.visible = true
			hover_sprite.visible = false
	else:
		if not no_hover:
			sprite.visible = false
			hover_sprite.visible = true
		if Input.is_action_just_pressed("click") and not $DialoguePlayer/Dialogue.visible:
			find_and_use_dialogue()
			

func _on_hover_mouse_entered():
	mouse_here = true


func _on_hover_mouse_exited():
	mouse_here = false
