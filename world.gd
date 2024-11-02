extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		Engine.time_scale = 0
		get_node("Inventory").set_visible(true)
		if Input.is_action_just_pressed("esc"):
			get_node("Inventory").set_visible(false)
			Engine.time_scale = 1
