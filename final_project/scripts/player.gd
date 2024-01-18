extends CharacterBody2D

class_name Player

@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 100
var direction = "down"
var health = 100
var is_attacking = false

signal died

func _physics_process(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("walk_down"):
		velocity.y = player_speed
		direction = "down"
		if !animated_sprite.is_playing():
			is_attacking = false
	if Input.is_action_pressed("walk_up"):
		velocity.y = -player_speed
		direction = "up"
	if !animated_sprite.is_playing():
			is_attacking = false
	if Input.is_action_pressed("walk_left"):
		velocity.x = -player_speed
		direction = "left"
		if !animated_sprite.is_playing():
			is_attacking = false
	if Input.is_action_pressed("walk_right"):
		velocity.x = player_speed
		direction = "right"
		if !animated_sprite.is_playing():
			is_attacking = false
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
	if is_attacking:
		velocity = Vector2()
	move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if animated_sprite :
		if Input.is_action_just_pressed("attack"):
			animated_sprite.play("attack_" + direction)
		if is_attacking != true:
			if velocity.x == 0 && velocity.y == 0 :
				animated_sprite.play("idle_" + direction)
			else:
				animated_sprite.play("walk_" + direction)
			

func _on_hurtbox_body_entered(body):
	health -= 50
	print(health)
	if health == 0:
		died.emit()

