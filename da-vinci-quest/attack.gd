extends BaseState
class_name PlayerAttack

var player 
var anim_player : AnimationPlayer

func manage_input() -> void:	
	var dir : Vector2 = Input.get_vector(player.left, player.right, player.up, player.down).normalized()

func enter():
	player = self.get_parent().get_parent()
	anim_player = player.get_animation_player()	

func update(delta: float) -> void:
	#print("attack")
	if not anim_player :
		anim_player = player.get_animation_player()
	
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("attack")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		Transitioned.emit(self,"Idle")
