extends CharacterBody2D

class_name Player

@onready var hurtbox = $Hurtbox
@onready var animated_sprite = $AnimatedSprite2D
@export var player_speed = 115
@export var push_speed = 75
var direction = "down"
@onready var player_stats = $"/root/PlayerStats"
var is_attacking = false
var enemies_to_attack = []
var player_died = false
var keys_collected = 0
var attack_power = 25

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
		if get_slide_collision_count() > 0:
			check_box_collision()

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
		if !is_attacking:
			is_attacking = true
			velocity = Vector2()
			attack()
	if Input.is_action_just_pressed("interact"):
		interaction.emit()

func attack():
	AudioPlayer.play_sfx("player_attack")
	is_attacking = true
	for body in enemies_to_attack:
		body.get_parent().take_damage(attack_power)
	await animated_sprite.animation_finished
	is_attacking = false

func take_damage(amount):
	if player_stats.player_health > 0:
		$AnimatedSprite2D/AnimationPlayer.play("damage")
		player_stats.player_health -= amount
		took_damage.emit()
		if player_stats.player_health <= 0:
			player_died = true
			animated_sprite.stop()
			animated_sprite.play("died")
			died.emit()

func check_box_collision():
	if velocity.x != 0 && velocity.y != 0:
		return
	var box = get_slide_collision(0).get_collider() as PushObject
	if box:
		box.push(velocity)


func _on_hitbox_area_entered(area):
	enemies_to_attack.append(area)


func _on_hitbox_area_exited(area):
	if enemies_to_attack.has(area):
		enemies_to_attack.erase(area)
