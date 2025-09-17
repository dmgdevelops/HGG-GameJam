extends Node2D

var current_scene = "DreamWorldForestStart"
@onready var morgan: CharacterBody2D = $Morgan
@onready var dialogue_starters: Area2D = $DialogueStarters



func _ready():
	pass
	

func _on_cave_entrance_body_entered(body):
	if body.is_in_group("Player"):
		change_scenes("DreamWorldRoomOfChoice")

func change_scenes(scene_name):
	if scene_name == "DreamWorldRoomOfChoice":
		get_tree().change_scene_to_file("res://Scenes/dream_world_room_of_choice.tscn")


func _on_dialogue_starters_body_entered(body: Node2D) -> void:
	print("Starting timeline")
	morgan.set_physics_process(false)
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start("Forest")
		
		
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	morgan.set_physics_process(true)
	print("ended forest timeline")
	remove_child(dialogue_starters)
