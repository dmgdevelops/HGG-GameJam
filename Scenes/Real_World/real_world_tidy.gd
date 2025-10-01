extends Node2D

@onready var DialogueSprite := %DialogueSpriteManager
@onready var DialogueBManager := %DialogueBoxManager

@onready var RoomExitArea := $stage/Room_exit
@onready var room_bgm := $BGM

# Scene States
var test = "j"


func _ready() -> void:
	RoomExitArea.connect('body_entered', on_room_exit_area_entered)
	room_bgm.play()

func on_room_exit_area_entered(_body : Node2D):
	print('room exited')
