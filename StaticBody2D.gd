extends CharacterBody2D


var right:bool
var atk:bool
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
var SPEED = 300.0


func _physics_process(delta):
	if Global.leveled:
		SPEED = SPEED*(1 + ((15/100)*(Global.itemlevel[5])))
		Global.Attacks = Global.Attacks + Global.itemlevel[3]
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	var direction2 = Input.get_axis("up", "down")
	if direction or direction2:
		velocity.x = direction * SPEED
		velocity.y = direction2 * SPEED
		if sqrt(pow(velocity.x, 2) + pow(velocity.y, 2)) > 300: 
			velocity.x = direction * SPEED * (sqrt(2)/2)
			velocity.y = direction2 * SPEED * (sqrt(2)/2)
		if Input.is_action_pressed("left"):
			anim.play("Lwalk")
			right = false
		elif Input.is_action_pressed("right"):
			anim.play("Rwalk")
			right = true
	else:
		velocity = Vector2.ZERO
		if right:
			anim.play("Ridle")
		else:
			anim.play("Lidle")
	if atk and right:
		anim.play("Ratk")
	elif atk:
		anim.play("Latk")
	move_and_slide()
