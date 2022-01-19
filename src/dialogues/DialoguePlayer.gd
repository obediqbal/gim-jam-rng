extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialogues = []
var current_dialogue_id = 0
var scene = 0
var npc = "NPC"
var is_dialogue_active = false

func play(current_scene, current_npc):
	if is_dialogue_active:
		return
	
	dialogues = load_dialogues()
	is_dialogue_active = true
	
	scene = current_scene
	npc = current_npc
	
	$Dialogue.visible = true
	turn_off_player()
	
	current_dialogue_id = -1
	next_line()
	
	
func _input(event):
	if not is_dialogue_active:
		return
	
	if event.is_action_pressed("interact"):
		next_line()
	
	
func next_line():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogues[scene]["Him"]):
		$Timer.start()
		$Dialogue.visible = false
		turn_on_player()
		return
	
	$Dialogue/NinePatchRect2/Name.text = dialogues[scene]["Him"][current_dialogue_id]["name"]	
	$Dialogue/NinePatchRect/Message.text = dialogues[scene]["Him"][current_dialogue_id]["text"]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())


func _on_Timer_timeout():
	is_dialogue_active = false


func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)
		

func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)
