extends Node2D

@onready var health = $Player.health
@onready var hud = $UI/HUD


func _ready():
	hud.set_health_label(health)
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door
		door.player_entered.connect(_on_door_entered)

func _on_player_died():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

func _on_skeleton_died():
	await get_tree().create_timer(1.0).timeout
	remove_child($Skeleton)


func _on_skeleton_2_died():
	await get_tree().create_timer(1.0).timeout
	remove_child($Skeleton2)


func _on_player_took_damage():
	health = $Player.health
	hud.set_health_label(health)

func _on_door_entered():
	print("door entered")
