extends CharacterBody2D

var random = RandomNumberGenerator.new()
var cower:bool = false
var run:bool = false
const SPEED = 100
@onready var tween = create_tween()
var tweening:bool = false
var TimeTweening:int
signal tweenstart
var FirstTween:bool = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		random.randomize()
		var randnum = random.randi_range(0, 100)
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
			if sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) > SPEED: 
				velocity.x = direction * SPEED * (sqrt(2)/2)
				velocity.y = direction2 * SPEED * (sqrt(2)/2)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
		move_and_slide()
	elif !run and !cower and !tweening:
		random.randomize()
		var randx = random.randi_range(-100, 100) 
		random.randomize()
		var randy = random.randi_range(-100, 100)
		TimeTweening = (abs(randx) + abs(randy))/50
		tweening = true
		tweenstart.emit()
		if !FirstTween:
			tween = create_tween()
		tween.tween_property(self, "position", Vector2(position.x + randx, position.y + randy), TimeTweening)
		FirstTween = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		cower = false
		run = false


func _on_tweenstart() -> void:
	await get_tree().create_timer(TimeTweening).timeout
	tweening = false