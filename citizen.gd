extends CharacterBody2D

var random = RandomNumberGenerator.new()
var cower:bool = false
var run:bool = false
const SPEED = 150

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		random.randomize()
		var randnum = random.randf_range(0, 100)
		if randnum < 41:
			run = true
		elif randnum > 40:
			cower = true

func _process(_delta: float) -> void:
	if run:
		var direction = Input.get_axis("left", "right")
		var direction2 = Input.get_axis("up", "down")
		if direction or direction2:
			velocity.x = direction * SPEED
			velocity.y = direction2 * SPEED
			if sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) > 300: 
				velocity.x = direction * SPEED * (sqrt(2)/2)
				velocity.y = direction2 * SPEED * (sqrt(2)/2)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
