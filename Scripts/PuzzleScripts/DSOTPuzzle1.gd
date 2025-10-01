extends Node

@onready var ground = $"../Ground"
@onready var steppableTiles = $SteppableTiles
@onready var outlineTiles = $Outlines
var morgan : Player

@onready var unsolvedBoundaries = $Outlines/StaticBody2D/UnsolvedBoundaries
@onready var solvedBoundaries = $Outlines/StaticBody2D/SolvedBoundaries

#dictionary to store locations of cracked tiles
var cracked_tiles := {}

#max number of crackable tiles (will be different for each puzzle)
var numCrackableTiles = 32

#gap tiles for unreachable area (will be different for each puzzle)
var leftTile = Vector2i(12,16)
var rightTile = Vector2i(13,16)

#if morgan fails a puzzle, where she respawns (will be different for each puzzle)
var morgan_respawn_tile = Vector2i(208,392)

var puzzleFinished = false

#IDs of tilesets that contain "fresh" tiles and "cracked tiles". Can be viewed in the TileSet tab.
const TILE_FRESH = 0
const TILE_CRACKED = 1

#variables to track tile coordinates. Needed for checking when Morgan is standing still on a cracked tile.
var current_tile_coordinates
var last_tile_coordinates

func _ready():
	morgan = PlayerManager.player
	unsolvedBoundaries.disabled = false
	solvedBoundaries.disabled = true

func _process(_delta):
	if not puzzleFinished:
		check_tile_under_player()

func check_tile_under_player():
	#morgans exact position on in the entire level
	var local_position_morgan = ground.to_local(morgan.Walkbox.global_position)
	#the coordinates of the tile Morgan is standing on.
	current_tile_coordinates = steppableTiles.local_to_map(local_position_morgan)
	#id of the tile if morgan is standing on it (-1 if morgan is not on the puzzle)
	var tile_id = steppableTiles.get_cell_source_id(current_tile_coordinates)
	
	if tile_id == TILE_FRESH:
		steppableTiles.set_cell(current_tile_coordinates, TILE_CRACKED, Vector2i(9,11))
		cracked_tiles[current_tile_coordinates] = true
		#win condition
		if cracked_tiles.size() == numCrackableTiles:
			finish_puzzle()
	elif tile_id == TILE_CRACKED and last_tile_coordinates != current_tile_coordinates:
		reset_level()
	
	last_tile_coordinates = current_tile_coordinates

func finish_puzzle():
	#fix all tiles in the puzzle
	for tile_coords in cracked_tiles.keys():
		steppableTiles.set_cell(tile_coords, TILE_FRESH, Vector2i(9,12))
	cracked_tiles.clear()
	
	#change boundaries to allow morgan to walk to blocked area
	unsolvedBoundaries.disabled = true
	solvedBoundaries.disabled = false
	
	#visually change gap to filled in tiles
	outlineTiles.set_cell(leftTile,TILE_FRESH, Vector2i(9,12))
	outlineTiles.set_cell(rightTile,TILE_FRESH, Vector2i(9,12))
	
	puzzleFinished = true

func reset_level():
	for tile_coords in cracked_tiles.keys():
		steppableTiles.set_cell(tile_coords, TILE_FRESH, Vector2i(8,11))
	cracked_tiles.clear()
	
	morgan.global_position = morgan_respawn_tile
	
