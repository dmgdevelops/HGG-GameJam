extends Node

signal  level_load_started

var current_tilemap_bounds : Array[Vector2]
signal TileMapBoundsChanged( bounds : Array[Vector2])

func ChangeTilemapBounds (bounds : Array [ Vector2 ]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit( bounds )

func load_new_level(level : String):
	
	get_tree().paused = true	
	
	await SceneTransition.fade_out()
	
	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(level)
	
	await SceneTransition.fade_in()
	
	get_tree().paused = false
