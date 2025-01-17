extends BaseState
class_name PlayerWalk

var player 
var anim_player : AnimationPlayer

@export var move_speed := 50.0

func _ready():
	player = get_parent().get_parent()

func manage_input() -> Vector2:	
	var dir : Vector2 = Input.get_vector(player.left, player.right, player.up, player.down).normalized()

	return dir

func update(delta : float) -> void:
	#print("walking")
	if not anim_player :
		anim_player = player.get_animation_player()
		
	var dir := manage_input()
	
	if dir.length() > 0 :
		player.velocity = dir * move_speed
	else :
		player.velocity = player.velocity.move_toward(Vector2.ZERO, 10)
		
	player.direction = dir

	
	if (player.velocity.length() == 0) :
		Transitioned.emit(self, "Idle")
	elif (Input.is_action_just_pressed(player.jump)):
		Transitioned.emit(self,"Jump")
	elif (!player.is_on_floor()):
		Transitioned.emit(self,"Falling")
	
func physics_update(delta: float) -> void:
	
	if (player.velocity.length() > 0) :
		if (player.velocity.x > 0 or player.velocity.x < 0) :
			anim_player.play("walk")
			if (player.velocity.x > 0) :
				player.sprite.flip_h = false
			elif (player.velocity.x < 0) :
				player.sprite.flip_h = true
