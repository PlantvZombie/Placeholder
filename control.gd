extends Control


func _process(delta: float) -> void:
	if visible:
		get_node("Panel/Label").set_text(str(get_node("/root/Global").Item))
