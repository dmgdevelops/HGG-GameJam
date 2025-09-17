extends Node2D

@onready var morgan = $Morgan
var current_scene = "DreamWorldRoomOfChoice"
@onready var dialogue_starters: Area2D = $dialogue_starters

func _ready():
	morgan.last_direction = Vector2i(0,-1)



func _on_cave_to_forest_body_entered(body):
	if body.is_in_group("Player"):
		change_scenes("DreamWorldForestStart")

func change_scenes(scene_name):
	if scene_name == "DreamWorldForestStart":
		get_tree().change_scene_to_file("res://Scenes/dream_world_forest_start.tscn")


func _on_dialogue_starters_body_entered(body: Node2D) -> void:
	print("Starting timeline")
	morgan.animated_sprite.play("idle_right")
	morgan.set_physics_process(false)
	if Dialogic.current_timeline != null:
		return
	else:
		Dialogic.timeline_ended.connect(ended)
		Dialogic.start("Choice")
		
		
func ended():
	Dialogic.timeline_ended.disconnect(ended)
	morgan.set_physics_process(true)
	print("ended room of choice timeline")
	remove_child(dialogue_starters)
