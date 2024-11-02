extends CharacterBody2D

@onready var player = $"../Player"
@onready var timer = $ShootTimer

@export var SPEED = 145.0
@export var SLOW_SPEED = 0.6
@export var firerate = 2.5
@export var Bullet : PackedScene


var canShoot = true
var canMove = true
var player_position



func _ready() -> void:
	timer.wait_time = firerate

func _physics_process(delta: float) -> void:
	if canMove == true:
		player_position = player.position
		if position.distance_to(player_position) >= 10:
			velocity = position.direction_to(player_position) * SPEED
			if position.distance_to(player_position) < 10:
				velocity = Vector2.ZERO
	elif canMove == false:
		player_position = player.position
		if position.distance_to(player_position):
			velocity = position.direction_to(player_position) * ((SPEED * SLOW_SPEED)* -1)
			if position.distance_to(player_position) < 10:
				velocity = Vector2.ZERO
	move_and_slide()


func shoot():
	if timer.wait_time >= 0:
		timer.stop()
		var b = Bullet.instantiate()
		$CollisionShape/Muzzle.look_at(player.position)
		owner.add_child(b)
		b.transform = $CollisionShape/Muzzle.global_transform
		timer.start(firerate)

func _on_shoot_timer_timeout() -> void:
	if canShoot:
		shoot()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canShoot = true
		canMove = false
		timer.start(firerate)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canShoot = false
		canMove = true
		timer.stop()
