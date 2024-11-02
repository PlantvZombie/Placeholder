extends CharacterBody2D


const SPEED = 300.0
var right

func _physics_process(delta):

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
	else:
		velocity = Vector2.ZERO
	move_and_slide()
