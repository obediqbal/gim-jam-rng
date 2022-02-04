extends CanvasLayer

onready var AnimationN = $Control/AnimationPlayer
var scene : String
var start_pos : Vector2


func change_scene(new_scene, anim, new_start_pos=null):
	scene = new_scene
	if new_start_pos!=null:
		start_pos = new_start_pos
	AnimationN.play(anim)	
	

func _new_scene():
	get_tree().change_scene(scene)
	
	
func _move_player():
	if get_parent().get_child(1).has_node('Player'):
		get_parent().get_child(1).get_node('Player').position = start_pos
