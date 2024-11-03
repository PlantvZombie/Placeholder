extends CharacterBody2D

@onready var player = $"../Player"

@export var SPEED = 145.0
var Hp:int = 100
var expgiven:int = 500
var stunned:bool = false

var player_position

func _physics_process(delta: float) -> void:
	player_position = player.position
	if player_position and !stunned:
		velocity = position.direction_to(player_position) * SPEED
		if position.distance_to(player_position) < 10:
			velocity = Vector2.ZERO
	if stunned:
		velocity = Vector2.ZERO
	move_and_slide()
