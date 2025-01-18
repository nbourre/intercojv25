class_name Worm
extends CharacterBody2D

@export var speed = 50  # Adjust this to change the NPC's speed
@export var move_distance = 100  # The distance the NPC will move in each direction

var anim_player : AnimationPlayer
var sprite : Sprite2D

var start_position : Vector2
var direction : int = 1 

func _ready():
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	start_position = global_position

func _physics_process(delta):
	anim_player = $AnimationPlayer
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player

func is_moving() -> bool:
	return velocity.length() > 0
