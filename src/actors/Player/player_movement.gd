extends "Player.gd"


func _physics_process(delta):
	var direction := get_direction()
	var velocity := Vector2(direction.x*speed, direction.y*speed)
	if velocity!=Vector2.ZERO:
		$AnimatedSprite.visible = true
		$Sprite.visible = false
		$AnimatedSprite.play()
		if direction.x>0:
			$AnimatedSprite.flip_h = true
			$Sprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
			$Sprite.flip_h = false
	else:
		$AnimatedSprite.visible = false
		$Sprite.visible = true
		$AnimatedSprite.stop()
	move_and_slide(velocity)


func get_direction() -> Vector2:
	# Mencari arah gerak player yang diberikan input
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")

	return Vector2(x, y)
