extends CharacterBody2D


var player

@onready var timer = $ShootTimer

@onready var anim = $CollisionShape/AnimatedSprite2D
@export var SPEED = 145.0
@export var SLOW_SPEED = 0.6
@export var firerate = 2.5
@export var Bullet : PackedScene
var Hp:int = 50
var expgiven:int = 500
var stunned:bool = false


var canShoot = true
var canMove = true
var player_position
var i


func _ready() -> void:
	var playerS = get_parent().get_children()
	for i in playerS:
		if i.is_in_group("player"):
			player = i
			break
	timer.wait_time = firerate

func _physics_process(delta: float) -> void:
	if canMove and !stunned:
		player_position = player.position
		if position.distance_to(player_position) >= 10:
			anim.play("Walk")
			velocity = position.direction_to(player_position) * SPEED
			if position.distance_to(player_position) < 10:
				anim.play("Idle")
				velocity = Vector2.ZERO
	elif !canMove and !stunned:
		player_position = player.position
		if position.distance_to(player_position) >= 10:
			velocity = position.direction_to(player_position) * (SPEED * SLOW_SPEED)
			anim.play("Walk")
			if position.distance_to(player_position) < 10:
				velocity = Vector2.ZERO

				anim.play("Idle")
		if position.direction_to(player_position).x/abs(position.direction_to(player_position).x) == 1:
			$CollisionShape/AnimatedSprite2D.set_flip_h(false)
		else:
			$CollisionShape/AnimatedSprite2D.set_flip_h(true)

	if stunned:
		velocity = Vector2.ZERO
	anim.play("Idle")

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
