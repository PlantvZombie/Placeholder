extends CharacterBody2D

@onready var player = $"../Player"
@onready var anim = $CollisionShape2D/AnimatedSprite2D
@export var SPEED = 145.0
var Hp:int = 100
var expgiven:int = 500

var player_position

func _physics_process(delta: float) -> void:
	player_position = player.position
	if player_position:
		anim.play("Walk")
		velocity = position.direction_to(player_position) * SPEED
		if position.distance_to(player_position) < 10:
			velocity = Vector2.ZERO
			anim.play("Idle")
	if position.direction_to(player_position).x/abs(position.direction_to(player_position).x) == 1:
		$CollisionShape2D/AnimatedSprite2D.set_flip_h(false)
	else:
		$CollisionShape2D/AnimatedSprite2D.set_flip_h(true)
	move_and_slide()
