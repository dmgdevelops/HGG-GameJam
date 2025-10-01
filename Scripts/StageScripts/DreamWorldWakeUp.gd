extends Node2D

@onready var middleDoorOpen = $BigDoor/BigDoorOpen
@onready var middleDoorClosed = $BigDoor/BigDoorClosed
@onready var middleDoorBarrier = $BigDoor/DoorCollisions/DoorBarrier

@onready var leftDoorOpen = $DoorLeft/ClosedDoor
@onready var leftDoorClosed = $DoorLeft/OpenDoor
@onready var leftDoorBarrier = $DoorLeft/DoorCollisions/DoorBarrier

@onready var rightDoorOpen = $DoorRight/ClosedDoor
@onready var rightDoorClosed = $DoorRight/OpenDoor
@onready var rightDoorBarrier = $DoorRight/DoorCollisions/DoorBarrier

func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	if Global.initialEncounterWithShadowMorgan == false:
		PlayerManager.player.set_physics_process(false)
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start("Forest")
	else:
		PlayerManager.player.set_physics_process(false)
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start("WakeUp")
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	PlayerManager.player.set_physics_process(true)
	print("ended current timeline")
