extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D
var player: CharacterBody2D
var attack_time = 1.0

func enter():
	enemy.velocity = Vector2()
	enemy.is_attacking = true
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 25 && !enemy.skeleton_died:
		await enemy.animated_sprite.animation_finished
		enemy.can_attack = true
		transitioned.emit(self, "EnemyFollow")

func update(delta: float):
	if enemy.can_attack:
		enemy.attack()

