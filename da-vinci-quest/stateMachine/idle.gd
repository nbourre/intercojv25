class_name PlayerIdle
extends BaseState


var player 
var anim_player : AnimationPlayer

func manage_input() -> void:	
	var dir : Vector2 = Input.get_vector(player.left, player.right, player.up, player.down).normalized()
	
	if (dir.length() > 0):
		Transitioned.emit(self, "Walk")
	elif (Input.is_action_just_pressed(player.jump)):
		Transitioned.emit(self,"Jump")

func enter():
	player = self.get_parent().get_parent()
	anim_player = player.get_animation_player()	

	
func update(delta: float) -> void:
	#print("idle")
	if not anim_player :
		anim_player = player.get_animation_player()
		
	player.velocity.x = 0
	
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("idle")
