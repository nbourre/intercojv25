class_name PlayerJump
extends BaseState

var player 
var anim_player : AnimationPlayer

@export var jump_force := -300.0

#var jump_sound = preload("res://Assets/Music/jump_sound.wav")

func _ready():
	player = get_parent().get_parent()

func manage_input() -> Vector2:	
	var dir : Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	return dir

func update(delta : float) -> void:
	#print("jumping")
	if not anim_player :
		anim_player = player.get_animation_player()

	var dir := manage_input()
	
	#AudioManager.play_sound(jump_sound)
	player.velocity.y = jump_force
	
	if(!player.is_on_floor()):
		Transitioned.emit(self,"Falling")
	

func physics_update(delta: float) -> void:
	
	if (player.velocity.length() > 0) :
		if (player.velocity.y > 0) :
			#AudioManager.play_sound(jump_sound)
			anim_player.play("jump")
			if (player.velocity.x > 0) :
				player.sprite.flip_h = false
			elif (player.velocity.x < 0) :
				player.sprite.flip_h = true
