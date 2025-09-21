extends Node2D

@onready var ground = $"../Ground"
@onready var icetiles = $IceTiles
@onready var dirttiles = $IceTiles/DirtTiles
@onready var morgan = $"../Morgan"

#ID 0 Atlas(1,22) (IceTiles)
#ID 0 Atlas(1,18) (DirtTiles)
const TILE_ID=0

var current_tile_coordinates
var last_tile_coordinates

func _ready():
	pass

func _physics_process(delta):
	#check_tile_under_player()
	if morgan.is_sliding:
		return
	
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = get_cardinal_direction(input_vector)
	if direction == Vector2.ZERO:
		return
	
	var local_position_morgan = ground.to_local(morgan.Walkbox.global_position)
	current_tile_coordinates = icetiles.local_to_map(local_position_morgan)
	var tile_id_ice = icetiles.get_cell_source_id(current_tile_coordinates)
	var tile_id_dirt= dirttiles.get_cell_source_id(current_tile_coordinates)
	
	if tile_id_dirt == TILE_ID:
		morgan.velocity = direction * morgan.speed
		morgan.move_and_collide(morgan.velocity * delta)
	elif tile_id_ice == TILE_ID:
		morgan.start_sliding(direction)

func get_cardinal_direction(vec):
#	give priority to left/right over up/down. maybe if time, implement this global (in FSM) to eliminate diagonal movement option.
	if abs(vec.x) >= abs(vec.y):
		return Vector2(sign(vec.x), 0)
	elif abs(vec.y) > 0:
		return Vector2(0, sign(vec.y))
	return Vector2.ZERO
