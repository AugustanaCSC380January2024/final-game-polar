extends Node2D

@onready var health = $Player.player_stats.player_health
@onready var hud = $UI/HUD


func _ready():
	hud.set_health_label(health)
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door.player_entered.connect(_on_door_entered.bind(door.next_level))
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.died.connect(_on_enemy_died.bind(enemy))

func _on_player_died():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

#func _on_skeleton_died():
#	await get_tree().create_timer(1.0).timeout
#	remove_child($Skeleton)


#func _on_skeleton_2_died():
#	await get_tree().create_timer(1.0).timeout
#	remove_child($Skeleton2)

func _on_enemy_died(enemy):
	await get_tree().create_timer(1.0).timeout
	remove_child(enemy)

func _on_player_took_damage():
	print("damage signal")
	health = $Player.player_stats.player_health
	hud.set_health_label(health)

func _on_door_entered(next_level):
	get_tree().change_scene_to_packed(next_level)
