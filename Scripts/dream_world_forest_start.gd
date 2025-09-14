extends Node2D

var current_scene = "DreamWorldForestStart"

func _ready():
	pass

func _on_cave_entrance_body_entered(body):
	if body.is_in_group("Player"):
		change_scenes("DreamWorldRoomOfChoice")

func change_scenes(scene_name):
	if scene_name == "DreamWorldRoomOfChoice":
		get_tree().change_scene_to_file("res://Scenes/dream_world_room_of_choice.tscn")
