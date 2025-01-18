extends Area2D

signal bullet_out_of_screen(bullet)

@export var speed = 750

var velocity = Vector2.ZERO

func _physics_process(delta):
	position += velocity * delta

	if is_out_of_screen():
		emit_signal("bullet_out_of_screen", self)

func is_out_of_screen() -> bool:
	var screen_rect = get_viewport_rect()
	return position.x < 0 or position.x > screen_rect.size.x or position.y < 0 or position.y > screen_rect.size.y

func set_direction(direction: Vector2):
	velocity = direction.normalized() * speed
	rotation = velocity.angle()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free() 
