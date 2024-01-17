extends CharacterBody2D

class_name Skeleton

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	move_and_slide()
	animated_sprite.play("walk_down")
	print("velocity " + str(velocity))
