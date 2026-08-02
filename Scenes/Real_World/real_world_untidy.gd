extends Node2D

@export var fade_speed : float = 0.5
@onready var DialogueSprite := %DialogueSpriteManager
@onready var DialogueBManager := %DialogueBoxManager

@onready var unlock_stages_secret = $stage/Room_entitites/unlock_stages_secret/actionable
@onready var book_actionable = $stage/Room_entitites/Room_mask/Control/Book/actionable
@onready var book_shader = $stage/Room_entitites/Room_mask/Control/Book/shaded_version

@onready var move_tutorial_area = $UI/move_tutorial/Area2D
@onready var move_tutorial = $UI/move_tutorial
@onready var interact_tutorial_area = $UI/Control/Area2D
@onready var interact_tutorial = $UI/Control/Interact_tutorial

@onready var morgan = %Morgan_untidy

signal morgan_sleep

var tween 
# Scene States
var test = "j"
var is_move_tutorial_exited := false
var is_interact_tutorial_triggered := false


func _ready() -> void:
	book_actionable.connect('book_triggered_once', turn_off_book_highlight)
	unlock_stages_secret.connect("unlock_stages_secret", unlock_stages)
	move_tutorial_area.connect('body_exited', move_tutorial_exited)
	interact_tutorial_area.connect('area_entered', interact_tutorial_event.bind('area_entered'))
	interact_tutorial_area.connect('area_exited', interact_tutorial_event.bind('area_exited'))
	tween = get_tree()

	interact_tutorial.modulate.a = 0
	
	MusicManager.stop_bg_music()

func unlock_stages():
	SaveSystem.data.DreamWorld = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld_door1 = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.save_data()
	MenuButtons.update_stages_menu()


# animating tutorials
func turn_off_book_highlight(): 
	book_shader.hide()
	is_interact_tutorial_triggered = true
	fade_out(interact_tutorial)

func interact_tutorial_event(_area: Area2D, p_event : StringName):
	if is_interact_tutorial_triggered:
		return
	match p_event:
		'area_entered':
			fade_in(interact_tutorial)
		'area_exited':
			fade_out(interact_tutorial)

func move_tutorial_exited(_body:Node2D):
	if is_move_tutorial_exited:
		return
	is_move_tutorial_exited = true
	fade_out(move_tutorial)


func fade_out(p_ui : Control):
	tween.create_tween().parallel().tween_property(p_ui, "modulate:a", 0 , fade_speed)
	tween.create_tween().parallel().set_ease(1).tween_property(p_ui, "position:y", p_ui.position.y + 20  , fade_speed)

func fade_in(p_ui: Control):
	tween.create_tween().parallel().tween_property(p_ui, "modulate:a", 1 , fade_speed)
	tween.create_tween().parallel().set_ease(1).tween_property(p_ui, "position:y", p_ui.position.y - 20  , fade_speed)


func _on_morgan_sleep() -> void:
	#var data = SaveData.new()
	#data.DreamWorld = data.menu_stages_state.UNLOCKED
	SaveSystem.data.DreamWorld = SaveSystem.data.menu_stages_state.UNLOCKED
	SaveSystem.save_data()
	MenuButtons.update_stages_menu()
	LevelManager.load_new_level("res://Scenes/Stages/FinalScenes/DreamWorld_WakeUp.tscn")
	print('sleep girl')

# KONYA ATASHI WA ROKUSUTAー
