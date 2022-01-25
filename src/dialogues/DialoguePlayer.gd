extends CanvasLayer

export(String, FILE, "*.json") var dialogue_intro
export(String, FILE, "*.json") var dialogue_level1
#export(String, FILE, "*.json") var dialogue_level2

var dialogues = []
var current_dialogue_id = 0
var scene = 0
var npc = "NPC"
var room = ""
var is_dialogue_active = false
onready var dialogue_file = [dialogue_intro, dialogue_level1]

func play(current_scene, current_npc, current_room):
	if is_dialogue_active:
		return
	
	scene = current_scene
	npc = current_npc
	room = current_room
	print(current_room)
	print('a')
	
	dialogues = load_dialogues(scene)
	is_dialogue_active = true
	
	
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
	
	if current_dialogue_id >= len(dialogues[room][npc]):
		$Timer.start()
		$Dialogue.visible = false
		turn_on_player()
		return
	
	$Dialogue/Name.text = dialogues[room][npc][current_dialogue_id]["name"]	
	$Dialogue/Message.text = dialogues[room][npc][current_dialogue_id]["text"]

func load_dialogues(level):
	var file = File.new()
	if file.file_exists(dialogue_file[level]):
		file.open(dialogue_file[level], file.READ)
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
