extends CharacterBody2D
class_name PushObject

func push(new_velocity: Vector2):
	velocity = new_velocity
	move_and_slide()
	
