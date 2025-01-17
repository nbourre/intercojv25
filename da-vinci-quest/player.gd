class_name Player
extends CharacterBody2D

var left : String = "left"
var right : String = "right"
var up : String = "up"
var down : String = "down"
var jump : String = "jump"

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var anim_player : AnimationPlayer
var sprite : Sprite2D
var direction : Vector2

func _ready():
	anim_player = $AnimationPlayer
	sprite = $Sprite2D
	anim_player.play("idle")

func _physics_process(delta):
	anim_player = $AnimationPlayer
	move_and_slide()
	
func get_animation_player () -> AnimationPlayer:
	return anim_player

func is_moving() -> bool:
	return velocity.length() > 0
