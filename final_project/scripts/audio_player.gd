extends Node
 
var player_attack = preload("res://assets/audio/07_human_atk_sword_1.wav")
var unlock = preload("res://assets/audio/Coin 1.wav")
var skeleton_die = preload("res://assets/audio/skeleton_die.wav")
var key = preload("res://assets/audio/unlock.wav")
var door = preload("res://assets/audio/06_door_close_2.mp3")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "player_attack":
		stream = player_attack
	elif sfx_name == "key":
		stream = key
	elif sfx_name == "skeleton_die":
		stream = skeleton_die
	elif sfx_name == "unlock":
		stream = unlock
	elif sfx_name == "door":
		stream = door
	else:
		return
	var player = AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	player.play()
	
