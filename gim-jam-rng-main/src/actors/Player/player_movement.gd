extends "Player.gd"


func _physics_process(delta):
	var direction := get_direction()
	var velocity := Vector2(direction.x*speed, direction.y*speed)
	move_and_slide(velocity)


func get_direction() -> Vector2:
	# Mencari arah gerak player yang diberikan input
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")

	return Vector2(x, y)
