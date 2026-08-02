extends Node2D

@onready var DialogueSprite := %DialogueSpriteManager
@onready var DialogueBManager := %DialogueBoxManager

@onready var RoomExitArea := $stage/Room_exit

@onready var book = $stage/Room_entitites/Room_mask/Control/Book/actionable

# Scene States
var book_triggered := false


func _ready() -> void:
	#RoomExitArea.connect('body_entered', on_room_exit_area_entered)
	MusicManager.play_bg_music(&"Morgan'sRoom")
	book.action_triggered.connect(func (): book_triggered = true)
	%Room_exit.action_triggered.connect(_game_end)
	if !%photoframe.is_visible_in_tree():
		%photoframe.show()

func on_room_exit_area_entered(_body : Node2D):
	print('room exited')

func _game_end():
	if !book_triggered:
		return
	LevelManager.load_new_level('res://UI/game_end.tscn')
	print('room exited')
