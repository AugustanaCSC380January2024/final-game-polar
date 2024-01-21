extends Control



func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/credits_2.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
