extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc") and get_node("Inventory2").is_visible() == false:
		get_node("Inventory2").set_visible(true)
	elif Input.is_action_just_pressed("esc"):
		get_node("Inventory2").set_visible(false)
	get_node("Inventory2").position = get_node("Player").position
