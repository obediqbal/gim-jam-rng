extends Control


func _on_StartGameButton_pressed():
	SceneChanger.change_scene('res://src/level/0/porch_scene.tscn', 'fade')


func _on_CreditsGameButton_pressed():
	SceneChanger.change_scene('res://src/world/credits.tscn', 'fade')
