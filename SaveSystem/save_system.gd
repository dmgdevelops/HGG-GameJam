extends Node

var data: SaveData

const path = "user://SaveData/GameData.tres"

func _ready() -> void:
	data = SaveData.new()

func save_data():
	#get_tree().call_group('menu_stages', ' ')
	var dir = DirAccess.open('user://')

	if !dir.dir_exists('SaveData'):
		dir.make_dir('SaveData')
	ResourceSaver.save(data, path)

func load_data():
	if not FileAccess.file_exists(path):
		printerr('Unable to load save data!')
		return
	data = ResourceLoader.load(path, '', ResourceLoader.CacheMode.CACHE_MODE_IGNORE)
	#get_tree().call_group('menu_stages', 'update_stages_menu')
