extends KinematicBody2D


var speed := 200.0


func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)

