extends Control



func _on_next_pressed():
	get_tree().change_scene_to_file("res://scenes/credits_2.tscn")


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
