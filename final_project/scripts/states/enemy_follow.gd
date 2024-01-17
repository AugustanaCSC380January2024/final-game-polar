extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 0:
		print("direction " +str(direction.normalized() * move_speed))
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()

