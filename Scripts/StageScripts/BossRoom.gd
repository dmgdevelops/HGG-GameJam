extends Node2D

@onready var doorClosed = $SmallDoor/ClosedDoor
@onready var doorOpen = $SmallDoor/OpenDoor
@onready var doorBarrier = $SmallDoor/DoorCollisions/DoorBarrier
@onready var boss: Boss = $DarkMorgan_boss
@onready var player_spawn: Node2D = $PlayerSpawn


func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_as_parent( self )
	PlayerManager.set_player_pos(player_spawn.global_position)
	LevelManager.level_load_started.connect ( _free_level )
	if Global.initialEncounterWithShadowMorgan == false:
		PlayerManager.player.set_physics_process(false)
		boss.state_machine.set_process(false)
		boss.state_machine.set_physics_process(false)
		Dialogic.timeline_ended.connect(ended)
		Dialogic.signal_event.connect( _on_dialogic_signal )
		Dialogic.start("MeetShadowMorgan")
		
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	PlayerManager.player.set_physics_process(true)
	print("ended first boss encounter")

func _on_dialogic_signal(arg : String):
	if arg == "sword":
		Global.initialEncounterWithShadowMorgan = true

func _free_level() -> void:
	queue_free()
	PlayerManager.unparent_player(self)
