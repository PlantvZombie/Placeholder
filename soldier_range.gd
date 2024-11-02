extends CharacterBody2D


@onready var timer = $ShootTimer

@export var firerate = 0.5
@export var Bullet : PackedScene
@onready var player = $"../Player"

var player_position
var SPEED = 145.0

func _physics_process(delta: float) -> void:
	player_position = player.position
	if position.distance_to(player_position) >= 10:
		velocity = position.direction_to(player_position) * SPEED
		if position.distance_to(player_position) < 10:
			velocity = Vector2.ZERO
	move_and_slide()
	if timer.time_left <= 0:
		timer.stop()


func shoot():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && timer.is_stopped() == true:
		shoot()
		timer.start(firerate)
