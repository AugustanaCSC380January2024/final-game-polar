extends State
class_name EnemyDied

@export var enemy: CharacterBody2D

func enter():
	print("enemy died")
	enemy.velocity = Vector2()
	enemy.can_attack = false
