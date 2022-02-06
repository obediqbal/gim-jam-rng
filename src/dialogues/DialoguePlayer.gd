extends CanvasLayer

export(String, FILE, "*.json") var dialogue_intro
export(String, FILE, "*.json") var dialogue_intro_scene
export(String, FILE, "*.json") var dialogue_level1
#export(String, FILE, "*.json") var dialogue_level2

var dialogues = {}
var current_dialogue_id = 0
var scene = 0
var npc = "NPC"
var room = ""
var is_dialogue_active = false
var is_choosing_decision_delay = false
var is_choosing_decision = false
var decision = -1
var current_parent = []
var current_dialogue = null
var next_scene = null
onready var dialogue_file = [dialogue_intro, dialogue_intro_scene, dialogue_level1]

func play(current_scene, current_npc, current_room, move_to_scene=null):
	if is_dialogue_active:
		return
	
	scene = current_scene
	npc = current_npc
	room = current_room
	next_scene = move_to_scene
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
	
	if (event.is_action_pressed("click") or event.is_action_pressed("interact")) and not is_choosing_decision:
		next_line()
	
	
func next_line():
	current_dialogue_id += 1
	if current_dialogue == null:
		current_parent = dialogues[room][npc]
		
		
	if len(current_parent)==0 or current_dialogue_id >= len(current_parent):
		$Timer.start()
		$Dialogue.visible = false
		turn_on_player()
		current_dialogue = null
		return
		
	$Dialogue/Options/Choice1.visible = false
	$Dialogue/Options/Choice2.visible = false
	$Dialogue/Options/Choice3.visible = false
	
		
	current_dialogue = current_parent[current_dialogue_id]
	
	if current_dialogue.has('change_scene_to_path'):
		SceneChanger.change_scene(current_dialogue['change_scene_to_path'], 'fade', Vector2(550,500))
		return
	print(current_dialogue)
		
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
		is_choosing_decision_delay = true
		$Timer.start()
		is_choosing_decision = true
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
	if is_choosing_decision_delay:
		is_choosing_decision_delay = false
	else:
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
	if is_choosing_decision_delay:
		return
	decision = 0
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	is_choosing_decision = false


func _on_Choice2_pressed():
	if is_choosing_decision_delay:
		return
	decision = 1
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	is_choosing_decision = false


func _on_Choice3_pressed():
	if is_choosing_decision_delay:
		return
	decision = 2
	if(current_dialogue["decision"]):
		current_parent = current_parent[current_dialogue_id+1][decision]
		current_dialogue_id = -1
	next_line()
	is_choosing_decision = false	
