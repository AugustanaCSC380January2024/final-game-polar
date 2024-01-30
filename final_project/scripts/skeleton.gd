extends CharacterBody2D

class_name Skeleton

@onready var animated_sprite = $AnimatedSprite2D

var player = null
var direction = "up"
var is_attacking = false
var skeleton_died = false
var can_attack = true
@export var health = 75

signal died

func _ready():
	$AnimatedSprite2D/AnimationPlayer.play("ready")

func _physics_process(delta):
	if is_attacking:
		velocity = Vector2()
	else:
		if velocity.x < 0:
			direction = "left"
		elif velocity.x > 0:
			direction = "right"
		elif velocity.y < 0:
			direction = "up"
		else:
			direction = "down"
		move_and_slide()
	update_animations(direction)

func update_animations(direction):
	if !skeleton_died:
		if is_attacking == true:
			animated_sprite.play("attack_" + direction)
		else:
			if velocity.x == 0 && velocity.y == 0 :
				animated_sprite.play("idle_" + direction)
			else:
				animated_sprite.play("walk_" + direction)

func _on_hurtbox_body_entered(body):
	pass

func take_damage(damage: int):
	health -= damage
	$AnimatedSprite2D/AnimationPlayer.play("damage")
	if health <= 0 && !skeleton_died:
		can_attack = false
		skeleton_died = true
		animated_sprite.play("died")
		died.emit()

func attack():
	if !skeleton_died:
		can_attack = false
		if player != null:
			await get_tree().create_timer(.2).timeout
			if !skeleton_died && !player == null:
				player.take_damage(10)
			await animated_sprite.animation_finished
			can_attack = true


func _on_hitbox_area_entered(area):
	player = area.get_parent()


func _on_hitbox_area_exited(area):
	if area.get_parent() == player:
		player = null
