extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
@onready var player_spawn: Node2D = $PlayerSpawn

var numEnemiesSlayed = 3

func _ready():
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	PlayerManager.set_player_pos(player_spawn.global_position)
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


func _on_next_room_trigger_body_entered(body):
	if body is Player and Global.morgan_enemies_slayed:
		LevelManager.load_new_level("res://Scenes/Stages/TestScenes/boss_room_1.tscn")
	
func _free_level() -> void:
	queue_free()
	PlayerManager.unparent_player(self)
