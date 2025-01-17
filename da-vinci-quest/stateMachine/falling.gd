extends BaseState
class_name PlayerFall

var player 
var anim_player : AnimationPlayer

@export var move_speed := 50.0

func _ready():
	player = get_parent().get_parent()

func manage_input() -> Vector2:	
	var dir : Vector2 = Input.get_vector(player.left, player.right, player.up, player.down).normalized()
	return dir

func update(delta : float) -> void:
	#print("falling")
	if not anim_player :
		anim_player = player.get_animation_player()
		
	var dir := manage_input()
	
	player.velocity += player.get_gravity() * delta
	
	if(player.is_on_floor()):
		Transitioned.emit(self,"Idle")
	
	player.direction = dir

func physics_update(delta: float) -> void:
	
	if (player.velocity.length() > 0) :
		if (player.velocity.y > 0) :
			if anim_player:
				anim_player.play("fall")
			if (player.velocity.x > 0) :
				player.sprite.flip_h = false
			elif (player.velocity.x < 0) :
				player.sprite.flip_h = true
