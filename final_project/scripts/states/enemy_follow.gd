extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var new_velocity
var player: CharacterBody2D

func enter():
	enemy.is_attacking = false
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() <= 30:
		transitioned.emit(self, "EnemyAttack")
	elif direction.length() > 30 && direction.length() <= 100:
		new_velocity = direction.normalized() * move_speed
	else:
		transitioned.emit(self, "EnemyWander")
	

func _physics_process(delta):
	if new_velocity != null:
		if enemy:
			enemy.velocity = new_velocity


