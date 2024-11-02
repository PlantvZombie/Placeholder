extends Control


func _process(_delta: float) -> void:
	get_node("Panel/Label").set_text(str(get_node("/root/Global").Item))
