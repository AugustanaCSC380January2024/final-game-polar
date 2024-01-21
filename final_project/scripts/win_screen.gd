extends Control

func _on_play_again_pressed():
	$"/root/PlayerStats".player_health = 100
	get_tree().change_scene_to_file("res://scenes/level.tscn")



func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
