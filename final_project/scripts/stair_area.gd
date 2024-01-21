extends Node2D

@export var next_level: PackedScene

signal player_entered_stairs

func _on_area_2d_body_entered(body):
	if body is Player:
		player_entered_stairs.emit()
