extends CharacterBody2D

var speed = 35

var is_rescued = false
var dir = Vector2()
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	dir = to_local(nav_agent.get_next_path_position()).normalized()
	print(dir.length())
	velocity = dir * speed
	move_and_slide()

func makepath() -> void:
	#print(dir.length())
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	if is_rescued:
		makepath()


func _on_interact_area_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().interaction.connect(_on_player_interact)

func _on_interact_area_area_exited(area):
	if area.get_parent() is Player:
		area.get_parent().interaction.disconnect(_on_player_interact)

func _on_player_interact():
	print("interact")
	is_rescued = true
	PlayerStats.historian_rescued = true
	$InteractArea.visible = false


