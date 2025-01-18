class_name WormIdle
extends BaseState

var worm 
var anim_player : AnimationPlayer

func enter():
	worm = self.get_parent().get_parent()
	anim_player = worm.get_animation_player()	

	
func update(delta: float) -> void:
	#print("idle")
	if not anim_player :
		anim_player = worm.get_animation_player()
	
func physics_update(delta: float) -> void:
	if not anim_player : return

	anim_player.play("Idle")
