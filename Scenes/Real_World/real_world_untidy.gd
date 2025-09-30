extends Node2D

@onready var DialogueSprite := %DialogueSpriteManager
@onready var DialogueBManager := %DialogueBoxManager

# Scene States
var test = "j"

func _ready() -> void:
	print(DialogueSprite, DialogueBManager)
	
# pass the dialogue box var to tweening func
