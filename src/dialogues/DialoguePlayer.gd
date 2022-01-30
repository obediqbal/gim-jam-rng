extends CanvasLayer

export(String, FILE, "*.json") var dialogue_intro
export(String, FILE, "*.json") var dialogue_level1
#export(String, FILE, "*.json") var dialogue_level2

var dialogues = {}
var current_dialogue_id = 0
var scene = 0
var npc = "NPC"
var room = ""
var is_dialogue_active = false
var choosing_decision = false
var decision = -1
var current_parent = []
var current_dialogue = {}
onready var dialogue_file = [dialogue_intro, dialogue_level1]

func play(current_scene, current_npc, current_room):
	if is_dialogue_active:
		return
	
	scene = current_scene
	npc = current_npc
	room = current_room
	
	dialogues = load_dialogues(scene)
	is_dialogue_active = true
	
	
	$Dialogue.visible = true
	current_parent = []
	turn_off_player()
	
	current_dialogue_id = -1
	next_line()
	
	
func _input(event):
	if not is_dialogue_active:
		return
	
	if (event.is_action_pressed("click") or event.is_action_pressed("interact")) and not choosing_decision:
		next_line()
	
	
func next_line():
	
	current_dialogue_id += 1
	
	
	if current_dialogue_id >= len(dialogues[room][npc]):
		$Timer.start()
		$Dialogue.visible = false
		turn_on_player()
		return
		
	$Dialogue/Options/Choice1.visible = false
	$Dialogue/Options/Choice2.visible = false
	$Dialogue/Options/Choice3.visible = false
	
	if len(current_parent)==0:
		current_parent = dialogues[room][npc]
		
	current_dialogue = current_parent[current_dialogue_id]
	print(current_parent)
	print(current_dialogue)
	print('----')
	
	#if decision != -1 && current_dialogue.get("decision"):
	#	current_parent = current_parent[current_dialogue_id+1][decision]
	#	decision = -1
	
		
	# atribut "name" kosong maka gunakan Dialogue Box NoName
	if current_dialogue.has("name") and current_dialogue["name"]=="":
		$Dialogue/WithName.visible = false
		$Dialogue/NoName.visible = true
	# tidak punya atribut "name" maka gunakan "name" sebelumnya
	else:
		if current_dialogue.has("name"):
			$Dialogue/WithName/Name.text = current_dialogue["name"]
		$Dialogue/NoName.visible = false
		$Dialogue/WithName.visible = true
		
	if current_dialogue.has("text"):
		$Dialogue/Message.text = current_dialogue["text"]
		
	if current_dialogue.has("decision"):
		choosing_decision = true
		var options = current_dialogue["option"]
		
		if options.size() >= 1:
			$Dialogue/Options/Choice1.visible = true
			$Dialogue/Options/Choice1/ChoiceContainer/Option.text = options[0]
		if options.size() >= 2:
			$Dialogue/Options/Choice2.visible = true
			$Dialogue/Options/Choice2/ChoiceContainer/Option.text = options[1]
		if options.size() >= 3:
			$Dialogue/Options/Choice3.visible = true
			$Dialogue/Options/Choice3/ChoiceContainer/Option.text = options[2]


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


func _on_Choice1_pressed():
	decision = 0
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	choosing_decision = false


func _on_Choice2_pressed():
	decision = 1
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	choosing_decision = false


func _on_Choice3_pressed():
	decision = 2
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	choosing_decision = false	
