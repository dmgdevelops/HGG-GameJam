extends Node2D

@onready var middleDoorOpen = $BigDoor/BigDoorOpen
@onready var middleDoorClosed = $BigDoor/BigDoorClosed
@onready var middleDoorBarrier = $BigDoor/DoorCollisions/DoorBarrier

@onready var leftDoorOpen = $DoorLeft/OpenDoor
@onready var leftDoorClosed = $DoorLeft/ClosedDoor
@onready var leftDoorBarrier = $DoorLeft/DoorCollisions/DoorBarrier

@onready var rightDoorOpen = $DoorRight/OpenDoor
@onready var rightDoorClosed = $DoorRight/ClosedDoor
@onready var rightDoorBarrier = $DoorRight/DoorCollisions/DoorBarrier

func _ready() -> void:
	#left door and right door closed, middle door open
	if Global.puzzle2Done:
		leftDoorBarrier.disabled = false #barrier intact
		leftDoorClosed.visible=true #door should look closed
		rightDoorBarrier.disabled = false
		rightDoorClosed.visible = true
		middleDoorBarrier.disabled = true
		middleDoorClosed.visible = false
	#left door and middle door closed, right door open
	elif Global.initialEncounterWithShadowMorgan:
		leftDoorBarrier.disabled = false #barrier intact
		leftDoorClosed.visible=true #door should look closed
		rightDoorBarrier.disabled = true
		rightDoorClosed.visible = false
		middleDoorBarrier.disabled = false
		middleDoorClosed.visible = true
	#right door and middle door closed, left door open
	else:
		leftDoorBarrier.disabled = true
		leftDoorClosed.visible=false
		rightDoorBarrier.disabled = false
		rightDoorClosed.visible = true
		middleDoorBarrier.disabled = false
		middleDoorClosed.visible = true
	
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

		
func change_scenes(scene_name):
	if scene_name == "PuzzleRoom1":
		get_tree().change_scene_to_file("res://Scenes/Stages/FinalScenes/PuzzleRoom1.tscn")
	if scene_name == "PuzzleRoom2":
		get_tree().change_scene_to_file("res://Scenes/Stages/FinalScenes/PuzzleRoom2.tscn")
	if scene_name == "PuzzleRoom3":
		get_tree().change_scene_to_file("res://Scenes/Stages/FinalScenes/PuzzleRoom3.tscn")

func _on_next_room_trigger_body_entered_left(body):
	if body.is_in_group("Player"):
		change_scenes("PuzzleRoom1")


func _on_next_room_trigger_body_entered_right(body):
	if body.is_in_group("Player"):
			change_scenes("PuzzleRoom2")


func _on_next_room_trigger_body_entered_middle(body):
	if body.is_in_group("Player"):
		change_scenes("PuzzleRoom3")
