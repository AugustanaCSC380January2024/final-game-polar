extends Node2D

@onready var health = $Player.player_stats.player_health
@onready var hud = $UI/HUD
@onready var player = get_tree().get_first_node_in_group("player")


func _ready():
	
	player.died.connect(_on_player_died)
	player.took_damage.connect(_on_player_took_damage)
	hud.set_health_label(health)
	hud.set_keys_label(player.player_stats.keys_collected)
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door.player_entered.connect(_on_door_entered.bind(door.next_level))
		door.key_used.connect(_on_key_used)
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.died.connect(_on_enemy_died.bind(enemy))
	
	var stairs = get_tree().get_nodes_in_group("stairs")
	for stair in stairs:
		stair.player_entered_stairs.connect(_on_stairs_entered.bind(stair.next_level))
	
	var keys = get_tree().get_nodes_in_group("keys")
	for key in keys:
		key.key_picked_up.connect(_on_key_picked_up.bind(key))

func _on_player_died():
	await get_tree().create_timer(1.0).timeout
	$"/root/PlayerStats".player_health = 100
	get_tree().reload_current_scene()
	

func _on_enemy_died(enemy):
	await get_tree().create_timer(0.8).timeout
	remove_child(enemy)

func _on_player_took_damage():
	health = $Player.player_stats.player_health
	hud.set_health_label(health)

func _on_door_entered(next_level):
	get_tree().change_scene_to_packed(next_level)

func _on_stairs_entered(next_level):
	get_tree().change_scene_to_packed(next_level)

func _on_key_picked_up(key):
	player.player_stats.keys_collected += 1
	hud.set_keys_label(player.player_stats.keys_collected)
	remove_child(key)

func _on_key_used():
	player.player_stats.keys_collected -= 1
	hud.set_keys_label(player.player_stats.keys_collected)
