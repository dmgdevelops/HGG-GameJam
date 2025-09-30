extends Node2D

@onready var boxes1 = $"../Boxes1"
@onready var boxes2 = $"../Boxes2"

signal reset_pressed

func _on_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("reset_pressed")
		
