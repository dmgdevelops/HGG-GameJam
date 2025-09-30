extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier


func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
