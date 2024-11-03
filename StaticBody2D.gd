extends CharacterBody2D


var right:bool
var up:bool
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var attackright = get_node("R/RightAttack/BatonRight")
@onready var attackleft = get_node("L/LeftAttack/BatonLeft")
@onready var attackup = get_node("U/UpAttack/BatonUp")
@onready var attackdown = get_node("D/DownAttack/BatonDown")
signal PlayerAttack
var dmg:int = 25
var SPEED = 300.0
var rattack:bool 
var uattack:bool

func _ready() -> void:
	get_node("Camera2D").set_block_signals(false)
	AttackingStuff()
	StunningCooldown()

func _physics_process(delta):
	if Global.leveled:
		dmg += dmg*(0.25)*Global.itemlevel[6]
		SPEED += SPEED*(0.15)*Global.itemlevel[5]
		Global.Attacks = Global.Attacks + Global.itemlevel[3]
		if Global.Attacks >= 3:
			Global.Attacks = 3
		get_node("D/DownAttack").set_scale(5*Global.itemlevel[0])
		get_node("L/LeftAttack").set_scale(5*Global.itemlevel[0])
		get_node("R/RightAttack").set_scale(5*Global.itemlevel[0])
		get_node("U/UpAttack").set_scale(5*Global.itemlevel[0])
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
			rattack = true
			uattack = false
		elif Input.is_action_pressed("right"):
			anim.play("Rwalk")
			right = true
			rattack = true
			uattack = false
		elif right:
			anim.play("Rwalk")
		else:
			anim.play("Lwalk")
		if Input.is_action_pressed("up"):
			up = true
			rattack = false
			uattack = true
		elif Input.is_action_pressed("down"):
			up = false
			rattack = false
			uattack = true

	else:
		velocity = Vector2.ZERO
		if right:
			anim.play("Ridle")
		else:
			anim.play("Lidle")
	move_and_slide()


func AttackingStuff():
	while Global.Attacks > 0:
		await get_tree().create_timer(1.5).timeout
		for i in Global.Attacks:
			if up and uattack:
				attackup.set_visible(true)
				attackup.play()
				get_node("U/UpAttack").set_disabled(false)
				await get_tree().create_timer(0.45).timeout
				attackup.stop()
				attackup.set_visible(false)
				get_node("U/UpAttack").set_disabled(true)
			elif right and rattack:
				attackright.set_visible(true)
				attackright.play()
				get_node("R/RightAttack").set_disabled(false)
				await get_tree().create_timer(0.45).timeout
				attackright.stop()
				attackright.set_visible(false)
				get_node("R/RightAttack").set_disabled(true)
			elif !right and rattack:
				attackleft.set_visible(true)
				attackleft.play()
				get_node("L/LeftAttack").set_disabled(false)
				await get_tree().create_timer(0.45).timeout
				attackleft.stop()
				attackleft.set_visible(false)
				get_node("L/LeftAttack").set_disabled(true)
			elif !up and uattack:
				attackdown.set_visible(true)
				attackdown.play()
				get_node("D/DownAttack").set_disabled(false)
				await get_tree().create_timer(0.45).timeout
				attackdown.stop()
				attackdown.set_visible(false)
				get_node("D/DownAttack").set_disabled(true)

func _on_r_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.Hp -= dmg
		if body.Hp < 1:
			Global.exp += body.expgiven
			body.queue_free()
		#PlayerAttack.emit()


func _on_l_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.Hp -= dmg
		if body.Hp < 1:
			Global.exp += body.expgiven
			body.queue_free()
		#PlayerAttack.emit()


func _on_d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.Hp -= dmg
		if body.Hp < 1:
			Global.exp += body.expgiven
			body.queue_free()
		#PlayerAttack.emit()


func _on_u_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		body.Hp -= dmg
		if body.Hp < 1:
			Global.exp += body.expgiven
			body.queue_free()
		#PlayerAttack.emit()

func StunningCooldown():
	while Global.Attacks > 0:
		await get_tree().create_timer(10).timeout
		get_node("Taser/Range").set_disabled(false)
		await get_tree().create_timer(0.1).timeout
		get_node("Taser/Range").set_disabled(true)


func _on_taser_body_entered(body: Node2D) -> void:
	print("working")
	if body.is_in_group("Enemies"):
		body.stunned = true
		await get_tree().create_timer(Global.itemlevel[1]).timeout
		if body.Hp > 0:
			body.stunned = false
