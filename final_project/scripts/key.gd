extends Sprite2D
class_name Key

var player = null
signal key_picked_up

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		player = area.get_parent()
		player.interaction.connect(_on_player_interact)

func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		player.interaction.disconnect(_on_player_interact)
		player = null

func _on_player_interact():
	key_picked_up.emit()
