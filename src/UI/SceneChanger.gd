extends CanvasLayer

onready var AnimationN = $Control/AnimationPlayer
var scene : String
var start_pos : Vector2
var camera : bool

func change_scene(new_scene, anim, new_start_pos=null, room_camera=true):
	scene = new_scene
	camera = room_camera
	if new_start_pos!=null:
		start_pos = new_start_pos
	AnimationN.play(anim)	
	

func _new_scene():
	get_tree().change_scene(scene)
	
	
func _move_player():
	if get_parent().get_child(1).has_node('Player'):
		get_parent().get_child(1).get_node('Player').position = start_pos


func _change_camera():
	if camera:
		return
	print('changing_camera')
	if get_parent().get_child(1).has_node('Player') and not get_parent().get_child(1).get_child(0).has_node('Camera2D'):
		get_parent().get_child(1).get_node('Player').get_node('Camera2D').make_current()
		print('changed_camera')
