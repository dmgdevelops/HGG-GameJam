extends CanvasLayer

@onready var DreamWorld_button: Button  = %DreamWorld

enum menu_stages_state { LOCKED, UNLOCKED }

var selected_menu_button : String
var selected_menu_content : String

var fade_speed := 0.2

@onready var current_menu_content = %SettingContents
var next_menu_content 

var credits_panel = preload("res://UI/credits_panel.tscn")
var credits : CanvasLayer

var stage_button_names := ['Dream World', 
	'Dream World Door 1',	'Dream World Door 2',
	'Dream World Door 3', 'Dream World Boss',
	'Real World 2'
]

@onready var stages_scenes := {
	&'TitleMenu': 'res://UI/title_screen.tscn',
	&'RealWorld' : "res://Scenes/Real_World/real_world_untidy2.tscn", 
	&'DreamWorld' : 'res://Scenes/Stages/FinalScenes/DreamWorld_WakeUp.tscn',
	&'DreamWorldDoor1' : 'res://Scenes//Stages/FinalScenes/PuzzleRoom1.tscn',
	&'DreamWorldDoor2' : 'res://Scenes/Stages/FinalScenes/PuzzleRoom2.tscn',
	&'DreamWorldDoor3' : 'res://Scenes/Stages/FinalScenes/PuzzleRoom3.tscn',
	&'DreamWorldBoss' : 'res://Scenes/Stages/TestScenes/boss_room_1.tscn',
	&'RealWorld2' : "res://Scenes/Real_World/real_world_tidy.tscn" 
}

var current_stage_scene

@export var bus_name : String
var bus_index : int


func _ready() -> void:
	self.hide()

	%Setting.connect('pressed', identify_menu_button.bind(%Setting, %SettingContents))
	%Stages.connect('pressed', identify_menu_button.bind(%Stages, %MenuStages))
	%Music.connect('pressed', identify_menu_button.bind(%Music, %MusicContents))
	%Credits.connect('pressed', show_credits_panel)
	%TitleMenu.connect('pressed', go_to_stage_scene.bind(stages_scenes['TitleMenu']))
	%Back.connect('pressed', toggle_visibility)
	
	#SaveSystem.data.DreamWorld = menu_stages_state.UNLOCKED
	#SaveSystem.data.DreamWorld_door3 = SaveSystem.data.menu_stages_state.LOCKED
	#SaveSystem.data.DreamWorld_boss = SaveSystem.data.menu_stages_state.UNLOCKED
	#SaveSystem.save_data()
	update_stages_menu()

	%MenuStages.hide()
	%MenuStages.modulate.a = 0
	%MusicContents.hide()
	%MusicContents.modulate.a = 0
	#%Credits.hide()
	#%Credits.modulate.a = 0

	%RealWorld.connect('pressed',go_to_stage_scene.bind(stages_scenes['RealWorld']))
	%DreamWorld.connect('pressed',go_to_stage_scene.bind(stages_scenes['DreamWorld']))
	%DreamWorld_door.connect('pressed',go_to_stage_scene.bind(stages_scenes['DreamWorldDoor1']))
	%DreamWorld_door2.connect('pressed',go_to_stage_scene.bind(stages_scenes['DreamWorldDoor2']))
	%DreamWorld_door3.connect('pressed',go_to_stage_scene.bind(stages_scenes['DreamWorldDoor3']))
	%DreamWorld_boss.connect('pressed',go_to_stage_scene.bind(stages_scenes['DreamWorldBoss']))
	%RealWorld2.connect('pressed',go_to_stage_scene.bind(stages_scenes['RealWorld2']))

	#if OS.get_name() == 'Web':
	#	%ForExecutable.hide()

	%Track1.connect('pressed', play_music_track.bind('ForestTheme'))
	%Track2.connect('pressed', play_music_track.bind('DarkMorgan'))
	%Track3.connect('pressed', play_music_track.bind("Morgan'sRoom"))

	bus_index = AudioServer.get_bus_index(bus_name)
	%MusicSettingSlider.value_changed.connect(_on_music_slider_value_changed)

	%FullscreenButton.toggled.connect(update_fullscreen_mode)
	apply_video_settings()
	%KeyControls.toggled.connect(show_keyboard_controls)

	#load settings
	%KeyControls.button_pressed = SaveSystem.data.KeyboardControlMenu
	show_keyboard_controls(SaveSystem.data.KeyboardControlMenu)


# pause and unpause
#func _input(event: InputEvent) -> void:
#	if event is InputEventKey and event.is_pressed():
#		if event.keycode == KEY_ESCAPE:
#			toggle_visibility()


func _unhandled_input(_event: InputEvent) -> void:
	#get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed("pause_game"):
			toggle_visibility()


func toggle_visibility():
	if !visible:
		self.show()
		get_tree().paused = true
	else:
		self.hide()
		get_tree().paused = false
	_save_music_slider_setting()


# load save data
func update_stages_menu():

	SaveSystem.load_data()
	#DreamWorld_button.text = SaveSystem.data.DreamWorld
	var music_db = linear_to_db(clamp(SaveSystem.data.MusicSettings, 0.0, 1.0))

	# 0 -- Dream World
	if SaveSystem.data.DreamWorld == menu_stages_state.UNLOCKED:
		%DreamWorld.disabled = false
		%DreamWorld.text = stage_button_names[0]
	elif SaveSystem.data.DreamWorld == menu_stages_state.LOCKED:
		%DreamWorld.disabled = true
		%DreamWorld.text = ' ' 
	#print(SaveSystem.data.DreamWorld)

	if SaveSystem.data.DreamWorld_door1 == menu_stages_state.UNLOCKED:
		%DreamWorld_door.disabled = false
		%DreamWorld_door.text = stage_button_names[1]
	elif SaveSystem.data.DreamWorld_door1 == menu_stages_state.LOCKED:
		%DreamWorld_door.disabled = true
		%DreamWorld_door.text = ' '

	if SaveSystem.data.DreamWorld_door2 == menu_stages_state.UNLOCKED:
		%DreamWorld_door2.disabled = false
		%DreamWorld_door2.text = stage_button_names[2]
	elif SaveSystem.data.DreamWorld_door2 == menu_stages_state.LOCKED:
		%DreamWorld_door2.disabled = true
		%DreamWorld_door2.text = ' '

	if SaveSystem.data.DreamWorld_door3 == menu_stages_state.UNLOCKED:
		%DreamWorld_door3.disabled = false
		%DreamWorld_door3.text = stage_button_names[3]
	elif SaveSystem.data.DreamWorld_door3 == menu_stages_state.LOCKED:
		%DreamWorld_door3.disabled = true
		%DreamWorld_door3.text = ' '
	
	# boss
	if SaveSystem.data.DreamWorld_boss == menu_stages_state.UNLOCKED:
		%DreamWorld_boss.disabled = false
		%DreamWorld_boss.text = stage_button_names[4]
	elif SaveSystem.data.DreamWorld_boss == menu_stages_state.LOCKED:
		%DreamWorld_boss.disabled = true
		%DreamWorld_boss.text = ' '
	
	# RealWorld
	#if SaveSystem.data.RealWorld == menu_stages_state.UNLOCKED:
	#elif SaveSystem.data.RealWorld == menu_stages_state.LOCKED:

	if SaveSystem.data.RealWorld2 == menu_stages_state.UNLOCKED:
		%RealWorld2.disabled = false
		%RealWorld2.text = stage_button_names[5]
	elif SaveSystem.data.RealWorld2 == menu_stages_state.LOCKED:
		%RealWorld2.disabled = true
		%RealWorld2.text = ' ' 

	AudioServer.set_bus_volume_db(bus_index, music_db)
	%MusicSettingSlider.value = SaveSystem.data.MusicSettings


# showing menu contents logic
func identify_menu_button(p_button: Button, p_content):
	if selected_menu_button == p_button.name:
		return
	selected_menu_button = p_button.name
	#print(p_button)
	
	selected_menu_content = p_content.name
	next_menu_content = p_content
	# current_menu_content = selected_menu_content

	animate_menu_contents()

	match p_button.name:
		'Setting':
			print('set')
	pass


func animate_menu_contents():

	# fade out last menu
	if current_menu_content != next_menu_content:

		var tween_what = get_tree().create_tween()
		tween_what.set_pause_mode(tween_what.TWEEN_PAUSE_PROCESS)
		tween_what.set_parallel()
		tween_what.set_ease(Tween.EASE_OUT)
		tween_what.tween_property(current_menu_content, 'modulate:a', 0, fade_speed )
		tween_what.tween_callback(current_menu_content.hide)

		current_menu_content = next_menu_content

	# fade in selected menu
	var tween = get_tree().create_tween()
	tween.set_pause_mode(tween.TWEEN_PAUSE_PROCESS)
	tween.set_parallel()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_callback(next_menu_content.show)
	tween.tween_property(next_menu_content, 'modulate:a', 1, fade_speed)


func go_to_stage_scene(p_stage_scene):
	self.hide()


	if p_stage_scene == stages_scenes['DreamWorldBoss']:
		Global.initialEncounterWithShadowMorgan = true
		Global.puzzle2Done = true
		LevelManager.load_new_level(p_stage_scene)
		return
	else:
		Global.initialEncounterWithShadowMorgan = false
		Global.puzzle2Done = false

	LevelManager.load_new_level(p_stage_scene)
	Dialogic.end_timeline()


func play_music_track(p_track):
	MusicManager.play_bg_music(p_track)

func _on_music_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(value)
	)

	#var linear_value = clamp(value / 100.0, 0.0, 1.0)
	#var linear_value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _save_music_slider_setting():
	SaveSystem.data.MusicSettings = %MusicSettingSlider.value
	SaveSystem.save_data()
	pass

func update_fullscreen_mode(toggled_on:bool):
	SaveSystem.data.Fullscreen = toggled_on
	apply_video_settings()

func apply_video_settings():
	%FullscreenButton.button_pressed = SaveSystem.data.Fullscreen
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if SaveSystem.data.Fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
	)

func show_keyboard_controls(toggled_on:bool):
	SaveSystem.data.KeyboardControlMenu = toggled_on
	if toggled_on:
		KeyboardControlsMenu.show()
	else:
		KeyboardControlsMenu.hide()

func show_credits_panel():
	credits = credits_panel.instantiate()
	add_child(credits)
	credits.credits_exited.connect(hide_credits)
	credits.show()

func hide_credits():
	credits.queue_free()

# for game end credits
func fade_out_credits():
	if credits == null:
		return
	var credits_control_node = credits.get_node('CreditsControl')
	get_tree().create_timer(5).timeout.connect(func(): if credits != null:
		credits.create_tween().tween_property(credits_control_node, 'modulate:a', 0 , 1).finished.connect(
			func (): if credits != null: hide_credits()))
