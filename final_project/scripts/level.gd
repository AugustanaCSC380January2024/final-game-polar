extends Node2D

@onready var health = $Player.player_stats.player_health
@onready var hud = $UI/HUD


func _ready():
	var player = get_tree().get_first_node_in_group("player")
	player.died.connect(_on_player_died)
	player.took_damage.connect(_on_player_took_damage)
	hud.set_health_label(health)
	var doors = get_tree().get_nodes_in_group("doors")
	for door in doors:
		door.player_entered.connect(_on_door_entered.bind(door.next_level))
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.died.connect(_on_enemy_died.bind(enemy))
	
	var stairs = get_tree().get_nodes_in_group("stairs")
	for stair in stairs:
		stair.player_entered_stairs.connect(_on_stairs_entered.bind(stair.next_level))

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
