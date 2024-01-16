extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 150
var direction = "down"

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("walk_down"):
		velocity.y = player_speed
		direction = "down"
	if Input.is_action_pressed("walk_up"):
		velocity.y = -player_speed
		direction = "up"
	if Input.is_action_pressed("walk_left"):
		velocity.x = -player_speed
		direction = "left"
	if Input.is_action_pressed("walk_right"):
		velocity.x = player_speed
		direction = "right"
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if velocity.x == 0 && velocity.y == 0:
		animated_sprite.play("idle_" + direction)
	else:
		animated_sprite.play("walk_" + direction)
		
