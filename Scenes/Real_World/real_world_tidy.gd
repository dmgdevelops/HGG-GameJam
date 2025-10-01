extends Node2D

@onready var DialogueSprite := %DialogueSpriteManager
@onready var DialogueBManager := %DialogueBoxManager

@onready var RoomExitArea := $stage/Room_exit
# Scene States
var test = "j"


func _ready() -> void:
	RoomExitArea.connect('body_entered', on_room_exit_area_entered)

func on_room_exit_area_entered(_body : Node2D):
	print('room exited')
