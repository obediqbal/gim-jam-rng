extends StaticBody2D

var mouse_here := false
onready var explanation := get_node("CanvasLayer")
onready var outline := $Outline


func _ready():
	outline.visible=false
	explanation.set_process(false)
	$CanvasLayer/TextureRect.set_stretch_mode(6)
	explanation.get_node("TextureRect").visible=false


func _process(delta):
	if mouse_here and Input.is_action_just_pressed("click") :
		explanation.get_node("TextureRect").visible=true
		turn_off_player()
	if mouse_here == false :
		if Input.is_action_just_pressed("click") :
			explanation.get_node("TextureRect").visible=false
			turn_on_player()


func _on_Area2D_mouse_entered():
	explanation.set_process(true)
	outline.visible=true
	mouse_here = true


func _on_Area2D_mouse_exited():
	outline.visible = false
	mouse_here = false


func turn_on_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(true)


func turn_off_player():
	var player = get_tree().get_root().find_node("Player", true, false)
	if player:
		player.set_active(false)
