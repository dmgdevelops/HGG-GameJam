extends Node

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
var numPagesToCollect = 4

func _ready():
	pass

func _process(_delta):
	if Global.morgan_page_collection == numPagesToCollect:
		doorBarrier.disabled = true
		doorClosed.visible=false
