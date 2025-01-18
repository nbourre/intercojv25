class_name WormWalk
extends BaseState

var worm
var anim_player: AnimationPlayer
var direction_changed = false

@export var min_shoot_interval : float = 0.5
@export var max_shoot_interval : float = 2
@export var bullet_speed : float = 50.0
@export var bullet_scene : PackedScene

var player : Node2D 
var shoot_timer : Timer

func enter():
	worm = self.get_parent().get_parent()
	anim_player = worm.get_animation_player()    
	direction_changed = false
	
	player = worm.get_parent().get_node("Leonardo")
	
	shoot_timer = Timer.new()
	add_child(shoot_timer)
	shoot_timer.connect("timeout", Callable(self, "_on_shoot_timer_timeout"))
	
	_start_shoot_timer()

func exit():
	if shoot_timer:
		shoot_timer.stop()
		shoot_timer.queue_free()

func _start_shoot_timer():
	var interval = randf_range(min_shoot_interval, max_shoot_interval)
	shoot_timer.start(interval)

func _on_shoot_timer_timeout():
	shoot_at_player()
	_start_shoot_timer()

func shoot_at_player():
	if player and bullet_scene:
		var bullet = bullet_scene.instantiate()
		worm.get_parent().add_child(bullet)
		bullet.global_position = worm.global_position
		var direction = (player.global_position - worm.global_position).normalized()
		bullet.set_direction(direction * bullet_speed)
	else:
		print("Player not found or bullet_scene not set!")
		
func _physics_process(delta: float) -> void:
	worm.velocity.x = worm.speed * worm.direction
	
	if abs(worm.global_position.x - worm.start_position.x) >= worm.move_distance:
		if not direction_changed:
			direction_changed = true
			_change_direction()
			await _delay(0.1) 
			direction_changed = false

func update(delta: float) -> void:
	if not anim_player:
		anim_player = worm.get_animation_player()

func physics_update(delta: float) -> void:
	if not anim_player: return
	anim_player.play("Walk")

func _change_direction() -> void:
	worm.direction *= -1  
	worm.position.y -= 1  
	worm.sprite.flip_h = worm.direction < 0

func _delay(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
