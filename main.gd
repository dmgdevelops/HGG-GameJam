extends Node

const path = SaveSystem.path
var data : SaveData

@onready var stages_menu = MenuButtons

func _ready() -> void:
	# load data
	data = SaveData.new()
	load_menu_data()
	#reset_stages_data()


func initiate_default_data():
	var save_dir = DirAccess.open("user://")
	if !save_dir.dir_exists("SaveData"):
		save_dir.make_dir("SaveData")

	ResourceSaver.save(data, path)


func load_menu_data():
	if not FileAccess.file_exists(path):
		initiate_default_data()
		return
	data = ResourceLoader.load(path, '', ResourceLoader.CacheMode.CACHE_MODE_IGNORE)
	stages_menu.update_stages_menu()

	# update menu

	# SaveSystem.load_data()

func reset_stages_data():
	var save_reset = SaveSystem.data.menu_stages_state.LOCKED
	SaveSystem.data.DreamWorld = save_reset
	SaveSystem.data.DreamWorld_door1 = save_reset
	SaveSystem.data.DreamWorld_door2 = save_reset
	SaveSystem.data.DreamWorld_door3 = save_reset
	SaveSystem.data.DreamWorld_boss = save_reset
	SaveSystem.data.RealWorld2 = save_reset
	SaveSystem.save_data()
	MenuButtons.update_stages_menu()

func on_unlock_all_stages():
	SaveSystem.data.DreamWorld = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld_door1 = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld_door2 = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld_door3 = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld_boss = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.RealWorld2 = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.save_data()
	MenuButtons.update_stages_menu()
