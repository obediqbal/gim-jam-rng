extends KinematicBody2D


var speed := 200.0



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
