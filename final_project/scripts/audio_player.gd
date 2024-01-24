extends Node
 
var player_attack = preload("res://assets/audio/07_human_atk_sword_1.wav")
var key = preload("res://assets/audio/Coin 1.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "player_attack":
		stream = player_attack
	elif sfx_name == "key":
		stream = key
	else:
		return
	var player = AudioStreamPlayer.new()
	player.stream = stream
	add_child(player)
	player.play()
	
