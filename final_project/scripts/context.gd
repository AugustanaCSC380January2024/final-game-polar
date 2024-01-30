extends Control

@onready var continue1 = $Panel/Continue1
@onready var continue2 = $Panel/Continue2
@onready var continue3 = $Panel/Continue3

@onready var label1 = $Panel/Label1
@onready var label2 = $Panel/Label2
@onready var label3 = $Panel/Label3




func _on_continue_1_pressed():
	label1.visible = false
	continue1.visible = false
	label2.visible = true
	continue2.visible = true


func _on_continue_2_pressed():
	label2.visible = false
	continue2.visible = false
	label3.visible = true
	continue3.visible = true

func _on_continue_3_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")
