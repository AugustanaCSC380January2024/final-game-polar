extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 40.0
var new_velocity
var player: CharacterBody2D

func enter():
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 25 && direction.length() <= 100:
		new_velocity = direction.normalized() * move_speed
	else:
		new_velocity = Vector2()
	
	if direction.length() > 100:
		transitioned.emit(self, "EnemyIdle")

func _physics_process(delta):
	if new_velocity != null:
		if enemy:
			enemy.velocity = new_velocity
