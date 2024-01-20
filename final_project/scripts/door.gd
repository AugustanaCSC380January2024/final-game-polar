extends Node2D

var player = null
signal player_entered

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player.interact.connect(_on_player_interact)

func _on_area_2d_body_exited(body):
	if body is Player:
		player.interact.disconnect(_on_player_interact)
		player = null

func _on_player_interact():
	player_entered.emit()
