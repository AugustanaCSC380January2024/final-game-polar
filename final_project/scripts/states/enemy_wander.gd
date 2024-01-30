extends State
class_name EnemyWander

@export var enemy: CharacterBody2D
@export var move_speed := 25.0

var player: CharacterBody2D

var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	#print(move_direction)

func enter():
	enemy.is_attacking = false
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()

func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func physics_update(delta):
	if enemy:
		enemy.velocity = move_direction * move_speed
		if enemy.velocity.x < 0:
			enemy.direction = "left"
		elif enemy.velocity.x > 0:
			enemy.direction = "right"
		elif enemy.velocity.y < 0:
			enemy.direction = "up"
		else:
			enemy.direction = "down"
		#enemy.move_and_slide()
		#enemy.update_animations(enemy.direction)
	
	var direction = player.global_position - enemy.global_position
	if direction.length() < 100:
		transitioned.emit(self, "EnemyFollow")
