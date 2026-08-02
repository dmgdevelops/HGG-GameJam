extends Node2D

@onready var middleDoorOpen = $BigDoor/BigDoorOpen
@onready var middleDoorClosed = $BigDoor/BigDoorClosed
@onready var middleDoorBarrier = $BigDoor/DoorCollisions/DoorBarrier

@onready var leftDoorOpen = $DoorLeft/OpenDoor
@onready var leftDoorClosed = $DoorLeft/ClosedDoor
@onready var leftDoorBarrier = $DoorLeft/DoorCollisions/DoorBarrier

@onready var rightDoorOpen = $DoorRight/OpenDoor
@onready var rightDoorClosed = $DoorRight/ClosedDoor
@onready var rightDoorBarrier = $DoorRight/DoorCollisions/DoorBarrier
@onready var player_spawn: Node2D = $PlayerSpawn

@onready var unlock_all_stages = %unlock_stages_secret.get_node('actionable')
@onready var DialogueSprite = %DialogueSpriteTest


func _ready() -> void:
	
	#For testing different flows
	#Global.puzzle2Done = true
	#Global.initialEncounterWithShadowMorgan = true

	#play bgm
	MusicManager.play_bg_music(&'ForestTheme')
	
	#left door and right door closed, middle door open
	if Global.puzzle2Done:
		leftDoorBarrier.disabled = false #barrier intact
		leftDoorClosed.visible=true #door should look closed
		rightDoorBarrier.disabled = false
		rightDoorClosed.visible = true
		middleDoorBarrier.disabled = true
		middleDoorClosed.visible = false
	#left door and middle door closed, right door open
	elif Global.initialEncounterWithShadowMorgan:
		leftDoorBarrier.disabled = false #barrier intact
		leftDoorClosed.visible=true #door should look closed
		rightDoorBarrier.disabled = true
		rightDoorClosed.visible = false
		middleDoorBarrier.disabled = false
		middleDoorClosed.visible = true
	#right door and middle door closed, left door open
	else:
		leftDoorBarrier.disabled = true
		leftDoorClosed.visible=false
		rightDoorBarrier.disabled = false
		rightDoorClosed.visible = true
		middleDoorBarrier.disabled = false
		middleDoorClosed.visible = true
	
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	PlayerManager.set_player_pos(player_spawn.global_position)
	LevelManager.level_load_started.connect ( _free_level )

	# first dreamworld dialogue
	if Global.initialEncounterWithShadowMorgan == false:
		#PlayerManager.player.set_physics_process(false)
		#Dialogic.timeline_ended.connect(ended)
		#Dialogic.start("Forest")
		%DialogueBoxManager.add_dialogue_box('Forest')
	elif Global.puzzle2Done:
		pass
	# after puzzle 1 dialogue
	else:
		#PlayerManager.player.set_physics_process(false)
		%DialogueBoxManager.add_dialogue_box('AcquireSword')
		#Dialogic.timeline_ended.connect(ended)
		#Dialogic.start("WakeUp")
		
	unlock_all_stages.connect('action_triggered', on_unlock_all_stages)


func ended():
	Dialogic.timeline_ended.disconnect(ended)
	PlayerManager.player.set_physics_process(true)
	print("ended current timeline")

		
func change_scenes(scene_name):
	if scene_name == "PuzzleRoom1":
		LevelManager.load_new_level("res://Scenes/Stages/FinalScenes/PuzzleRoom1.tscn")
		_save_unlocked_stages('puzzle 1')
		
	if scene_name == "PuzzleRoom2":
		LevelManager.load_new_level("res://Scenes/Stages/FinalScenes/PuzzleRoom2.tscn")
		_save_unlocked_stages('puzzle 2')
		
	if scene_name == "PuzzleRoom3":
		LevelManager.load_new_level("res://Scenes/Stages/FinalScenes/PuzzleRoom3.tscn")
		_save_unlocked_stages('puzzle 3')

func _on_next_room_trigger_body_entered_left(body):
	if body.is_in_group("Player"):
		change_scenes("PuzzleRoom1")


func _on_next_room_trigger_body_entered_right(body):
	if body.is_in_group("Player"):
			change_scenes("PuzzleRoom2")


func _on_next_room_trigger_body_entered_middle(body):
	if body.is_in_group("Player"):
		change_scenes("PuzzleRoom3")

func _free_level() -> void:
	queue_free()
	PlayerManager.unparent_player(self)

func _save_unlocked_stages(p_puzzle:String):
	var save = SaveSystem.data.menu_stages_state.UNLOCKED
	var data = SaveSystem.data
	match p_puzzle:
		'puzzle 1':
			data.DreamWorld_door1 = save
		'puzzle 2':
			data.DreamWorld_door2 = save
		'puzzle 3':
			data.DreamWorld_door3 = save
		_:
			printerr('unknown puzzle!')
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

	print('unlock')

