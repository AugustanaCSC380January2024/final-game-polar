extends Sprite2D
class_name HealthPotion

var player = null
signal health_potion_used



func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		$Label.visible = true
		player = area.get_parent()
		player.interaction.connect(_on_player_interact)


func _on_area_2d_area_exited(area):
	if area.get_parent() is Player:
		$Label.visible = false
		player.interaction.disconnect(_on_player_interact)
		player = null

func _on_player_interact():
	health_potion_used.emit()
