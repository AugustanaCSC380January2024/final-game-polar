extends Node2D

var health = 100

func _on_player_died():
	get_tree().reload_current_scene()



func _on_skeleton_died():
	print("test")
