extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
@onready var player_spawn: Node2D = $PlayerSpawn

@export var  numPagesToCollect = 3

func _ready():
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	PlayerManager.set_player_pos(player_spawn.global_position)
	MusicManager.play_bg_music(&'ForestTheme')
	pass

func _process(_delta):
	if Global.morgan_page_collection == numPagesToCollect:
		doorBarrier.disabled = true
		doorClosed.visible=false


func _on_next_room_trigger_body_entered(body):
	if body is Player:
		LevelManager.load_new_level("res://Scenes/Stages/TestScenes/boss_room_1.tscn")

	#SaveSystem.data.DreamWorld_door2 = SaveSystem.data.menu_stages_state.UNLOCKED
	#SaveSystem.save_data()
	MenuButtons.update_stages_menu()
	
func _free_level() -> void:
	queue_free()
	PlayerManager.unparent_player(self)
