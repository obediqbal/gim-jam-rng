extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialogues = []
var current_dialogue_id = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	play()


func play():
	dialogues = load_dialogues()
	
	current_dialogue_id = -1
	next_line()
	
	
func _input(event):
	if event.is_action_pressed("interact"):
		next_line()
		print('a')
	
	
func next_line():
	current_dialogue_id += 1
	
	if current_dialogue_id >= len(dialogues["scene_1"]["NPC"]):
		queue_free()
		return
	
	$NinePatchRect2/Name.text = dialogues["scene_1"]["NPC"][current_dialogue_id]["name"]	
	$NinePatchRect/Message.text = dialogues["scene_1"]["NPC"][current_dialogue_id]["text"]

func load_dialogues():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())
