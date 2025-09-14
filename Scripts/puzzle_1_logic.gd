extends Node

@onready var ground = $"../ground"
@onready var relief1tilemap = $"../Puzzle1Relief"
@onready var morgan = $"../Morgan"

#dictionary to store locations of cracked tiles
var cracked_tiles := {}

#IDs of tilesets that contain "fresh" tiles and "cracked tiles". Can be viewed in the TileSet tab.
const TILE_FRESH = 5
const TILE_CRACKED = 0

#variables to track tile coordinates. Needed for checking when Morgan is standing still on a cracked tile.
var current_tile_coordinates
var last_tile_coordinates

func _process(_delta):
	check_tile_under_player()

func check_tile_under_player():
	#morgans exact position on in the entire level
	var local_position_morgan = ground.to_local(morgan.global_position)
	#the coordinates of the tile Morgan is standing on.
	current_tile_coordinates = relief1tilemap.local_to_map(local_position_morgan)
	#id of the tile if morgan is standing on it (-1 if morgan is not on the puzzle)
	var tile_id = relief1tilemap.get_cell_source_id(current_tile_coordinates)
	
	if tile_id == TILE_FRESH:
		relief1tilemap.set_cell(current_tile_coordinates, TILE_CRACKED, Vector2i(11,18))
		cracked_tiles[current_tile_coordinates] = true
	elif tile_id == TILE_CRACKED and last_tile_coordinates != current_tile_coordinates:
		reset_level()
	
	last_tile_coordinates = current_tile_coordinates

func reset_level():
	for tile_coords in cracked_tiles.keys():
		relief1tilemap.set_cell(tile_coords, TILE_FRESH, Vector2i(2,6))
	cracked_tiles.clear()
	
	var spawn_tile = Vector2i(0,0)
	morgan.global_position = spawn_tile
	
