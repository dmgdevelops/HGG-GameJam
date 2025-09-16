extends Node2D

@onready var morgan = $Morgan
var current_scene = "DreamWorldRoomOfChoice"

func _ready():
	morgan.last_direction = Vector2i(0,-1)



func _on_cave_to_forest_body_entered(body):
	if body.is_in_group("Player"):
		change_scenes("DreamWorldForestStart")

func change_scenes(scene_name):
	if scene_name == "DreamWorldForestStart":
		get_tree().change_scene_to_file("res://Scenes/Stages/dream_world_forest_start.tscn")
	elif scene_name == "PuzzleRoom1":
		get_tree().change_scene_to_file("res://Scenes/Stages/puzzle_room_1.tscn")


func _on_to_puzzle_room_1_body_entered(body):
	if body.is_in_group("Player"):
		change_scenes("PuzzleRoom1")
