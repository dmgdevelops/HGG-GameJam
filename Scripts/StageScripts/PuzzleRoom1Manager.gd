extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
var numPagesToCollect = 3

func _ready():
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	pass

func _process(_delta):
	if Global.morgan_page_collection == numPagesToCollect:
		doorBarrier.disabled = true
		doorClosed.visible=false
