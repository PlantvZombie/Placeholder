extends Area2D

@export var speed = 750
@export var damage = 10
#@export var damage = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Global").playerhealth -= damage
	queue_free()
