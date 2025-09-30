extends Node

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
var numEnemiesSlayed = 3

func _ready():
	pass

func _process(_delta):
	if Global.morgan_enemies_slayed == numEnemiesSlayed:
		doorBarrier.disabled = true
		doorClosed.visible=false


func _on_reset_button_reset_pressed():
	var boxes1 = $Boxes1.get_children()
	for box in boxes1:
			box.get_child(0).reset_position()
	
	var boxes2 = $Boxes2.get_children()
	for box in boxes2:
			box.get_child(0).reset_position()
	pass # Replace with function body.
