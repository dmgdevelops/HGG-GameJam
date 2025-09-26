extends Node

const MORGAN = preload("res://Scenes/Characters/Morgan.tscn")
var player: Player

func _ready() -> void:
	add_player_instance()

func add_player_instance() -> void:
	player = MORGAN.instantiate()
	add_child( player )
	pass
