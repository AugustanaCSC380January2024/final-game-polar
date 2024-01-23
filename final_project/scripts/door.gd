extends Node2D

@export var next_level: PackedScene

var player = null
var unlocked = false
signal player_entered
signal key_used

func _ready():
	$Enter.visible = false
	$Locked.visible = false
	$Unlock.visible = false

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
	if unlocked == false:
		if player.player_stats.keys_collected == 0:
			$Locked.visible = true
		else:
			$Unlock.visible = true
			player.interaction.connect(_on_player_interact)
	else:
		$Enter.visible = true
		player.interaction.connect(_on_player_interact)
	

func _on_area_2d_body_exited(body):
	$Enter.visible = false
	$Locked.visible = false
	$Unlock.visible = false
	if body is Player:
		player.interaction.disconnect(_on_player_interact)
		player = null

func _on_player_interact():
	if unlocked == false:
		key_used.emit()
		unlocked = true
		$Unlock.visible = false
		$Enter.visible = true
	else:
		player_entered.emit()
