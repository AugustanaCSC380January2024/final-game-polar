extends CharacterBody2D

class_name Player

@onready var hurtbox = $Hurtbox
@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 100
var direction = "down"
var health = 100
var is_attacking = false
var enemies_to_attack = []
var player_died = false

signal died
signal took_damage

func _physics_process(delta):
	if !player_died:
		if !Input.is_anything_pressed():
			velocity = Vector2()
		move_and_slide()
		update_animations(direction)

func update_animations(direction):
	if animated_sprite :
		if !player_died:
			if Input.is_action_just_pressed("attack"):
				animated_sprite.play("attack_" + direction)
			if is_attacking != true:
				if velocity.x == 0 && velocity.y == 0 :
					animated_sprite.play("idle_" + direction)
				else:
					animated_sprite.play("walk_" + direction)

func _input(event):
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
		attack()
	if is_attacking:
		velocity = Vector2()

func attack():
	for body in enemies_to_attack:
		body.get_parent().take_damage(10)

func _on_hurtbox_area_entered(area):
	if area.get_parent() is Skeleton:
		print("take damage")
		health -= 100
		took_damage.emit()
		if health <= 0:
			player_died = true
			animated_sprite.stop()
			animated_sprite.play("died")
			died.emit()

func _on_hurtbox_area_exited(area):
	pass


func _on_hitbox_area_entered(area):
	print("hitbox entered")
	enemies_to_attack.append(area)


func _on_hitbox_area_exited(area):
	print("hitbox exited")
	if enemies_to_attack.has(area):
		enemies_to_attack.erase(area)
