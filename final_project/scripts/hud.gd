extends Control

func set_health_label(health):
	if health >= 0:
		$Health.text = "HEALTH: " + str(health)
	else:
		$Health.text = "HEALTH: 0"

func set_keys_label(keys):
	$Keys.text = "X " + str(keys)


