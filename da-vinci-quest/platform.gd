@tool
extends Node2D

var prev_length : int = 3;

@export var length : int = 3 :
	get : return length
	set(value) :
		if (value >= 3):
			prev_length = length
			length = value
			set_length(value)
		
		
		
@onready var tile_map := $TileMapLayer

const left_tip := Vector2i(8, 2)
const right_tip := Vector2i(10,2)
const middle := Vector2i(9, 2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_length(value) -> void :
	if (tile_map == null):
		tile_map = $TileMapLayer
		
	#var pos := Vector2i(1, 0)
	#print(tile_map.get_cell_tile_data(pos))
	#print(tile_map.get_cell_atlas_coords(pos))
	var start_pos := Vector2i(0, 0)
	var end_pos := Vector2(value - 1, 0)
	
	tile_map.set_cell(start_pos, 1, left_tip)
	for i in range(1, value - 1):
		var pos := Vector2i(i, 0)
		tile_map.set_cell(pos, 1, middle)
		
	tile_map.set_cell(end_pos, 1, right_tip)
	
	if (prev_length <= value):
		return
		
	for i in range (value, prev_length) :
		var pos := Vector2i(i, 0)
		tile_map.set_cell(pos)
