extends Control

func _ready():
	if PlayerStats.historian_rescued:
		$WinLabel.visible = true
		$LoseLabel.visible = false
	else:
		$WinLabel.visible = false
		$LoseLabel.visible = true

func _on_play_again_pressed():
	$"/root/PlayerStats".player_health = 100
	$"/root/PlayerStats".keys_collected = 0
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")



func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_exit_pressed():
	get_tree().quit()
