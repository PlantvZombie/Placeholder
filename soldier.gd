extends CharacterBody2D

@onready var player = $"../Player"
var player_position
var target_position
var SPEED = 145.0

func _physics_process(delta: float) -> void:
	player_position = player.position
	target_position = (player_position - position).normalized()
	if target_position or player_position:
		if position.distance_to(player_position) >= 5:
			move_and_collide(player_position)
	else:
			pass
