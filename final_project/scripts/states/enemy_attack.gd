extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func enter():
	enemy.velocity = Vector2()
	enemy.is_attacking = true
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	#print("attack")
	if direction.length() > 25:
		transitioned.emit(self, "EnemyFollow")
	
