extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@export var puzzle_door: PuzzleDoor

signal pressed
signal unpressed



func _on_body_entered(body):
	if !body is PushObject:
		return
	animated_sprite.play("pressed")
	pressed.emit()


func _on_body_exited(body):
	if !body is PushObject:
		return
	animated_sprite.play("unpressed")
	unpressed.emit()
