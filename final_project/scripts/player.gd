extends CharacterBody2D

class_name Player

@onready var hurtbox = $Hurtbox
@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 100
var direction = "down"
@onready var player_stats = $"/root/PlayerStats"
var is_attacking = false
var can_attack = true
var enemies_to_attack = []
var player_died = false
var keys_collected = 0

signal died
signal took_damage
signal interaction
signal key_collected

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
	if Input.is_action_just_released("walk_down") || Input.is_action_just_released("walk_up"):
		velocity.y = 0
	if Input.is_action_just_released("walk_left") || Input.is_action_just_released("walk_right"):
		velocity.x = 0
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
		if can_attack:
			is_attacking = true
			velocity = Vector2()
			#if !animated_sprite.is_playing():
			attack()
	if Input.is_action_just_pressed("interact"):
		interaction.emit()

func attack():
	AudioPlayer.play_sfx("player_attack")
	can_attack = false
	for body in enemies_to_attack:
		body.get_parent().take_damage(50)
	await animated_sprite.animation_finished
	can_attack = true

func take_damage(amount):
	player_stats.player_health -= amount
	took_damage.emit()
	if player_stats.player_health <= 0:
		player_died = true
		animated_sprite.stop()
		animated_sprite.play("died")
		died.emit()
		
func interact():
	pass

func _on_hurtbox_area_entered(area):
	pass

func _on_hurtbox_area_exited(area):
	pass


func _on_hitbox_area_entered(area):
	enemies_to_attack.append(area)


func _on_hitbox_area_exited(area):
	if enemies_to_attack.has(area):
		enemies_to_attack.erase(area)

#Area2D
