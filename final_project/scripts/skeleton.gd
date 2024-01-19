extends CharacterBody2D

class_name Skeleton

@onready var animated_sprite = $AnimatedSprite2D

var direction = "up"
var is_attacking = false
@export var health = 100

signal died

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
	print(health)
	died.emit()
	if health <= 0:
		print("test")
		died.emit()
