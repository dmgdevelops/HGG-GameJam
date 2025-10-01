extends Node2D



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
