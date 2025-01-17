class_name WormWalk
extends BaseState

var worm
var anim_player: AnimationPlayer
var direction_changed = false

func enter():
	worm = self.get_parent().get_parent()
	anim_player = worm.get_animation_player()	
	direction_changed = false

func _physics_process(delta: float) -> void:
	worm.velocity.x = worm.speed * worm.direction
	
	if abs(worm.global_position.x - worm.start_position.x) >= worm.move_distance:
		if not direction_changed:  # Prevent repeated flipping in the same frame
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
