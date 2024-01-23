extends Control

func set_health_label(health):
	$Health.text = "HEALTH: " + str(health)

func set_keys_label(keys):
	$Keys.text = "X " + str(keys)


