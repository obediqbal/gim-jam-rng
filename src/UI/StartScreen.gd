extends Control


func _on_StartGameButton_pressed():
	SceneChanger.change_scene('res://src/level/intro.tscn', 'fade')
