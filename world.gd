extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc") and get_node("Inventory").is_visible() == false:
		get_node("Inventory").set_visible(true)
	elif Input.is_action_just_pressed("esc"):
		get_node("Inventory").set_visible(false)
	get_node("Inventory").position = get_node("Player").position
