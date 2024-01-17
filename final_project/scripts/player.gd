extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 100
var direction = "down"
var health = 100

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
	if Input.is_action_just_pressed("attack"):
		animated_sprite.play("attack")
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if animated_sprite :
		if velocity.x == 0 && velocity.y == 0:
			animated_sprite.play("idle_" + direction)
		else:
			animated_sprite.play("walk_" + direction)
			
func _input(event):
	if event.is_action_pressed("attack"):
		print("attack")
		animated_sprite.play("attack")
