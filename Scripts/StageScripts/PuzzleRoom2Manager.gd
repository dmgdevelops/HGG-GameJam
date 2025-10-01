extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
var numPicsToCollect = 4

func _ready():
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	pass

func _process(_delta):
	if Global.morgan_picture_collection == numPicsToCollect:
		doorBarrier.disabled = true
		doorClosed.visible=false


func _on_next_room_trigger_body_entered(body):
	get_tree().change_scene_to_file("res://Scenes/Stages/FinalScenes/DreamWorld_WakeUp.tscn")
