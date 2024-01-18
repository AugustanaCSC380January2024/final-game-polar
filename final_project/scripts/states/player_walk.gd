extends State
class_name PlayerWalk

@export var player: CharacterBody2D
var player_speed = 100
var direction
func handle_input(event):
	if Input.is_action_pressed("walk_down"):
		player.velocity.y = player_speed
		direction = "down"
	if Input.is_action_pressed("walk_up"):
		player.velocity.y = -player_speed
		direction = "up"
	if Input.is_action_pressed("walk_left"):
		player.velocity.x = -player_speed
		direction = "left"
	if Input.is_action_pressed("walk_right"):
		player.velocity.x = player_speed
		direction = "right"

func physics_update(delta):
	pass
