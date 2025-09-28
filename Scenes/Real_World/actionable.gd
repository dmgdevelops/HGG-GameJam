extends Area2D

@export var dialogue_resource : DialogueResource 
@export var dialogue_start: String = "start"

signal light_switch_pressed

func action():
	# show the dialogue
	light_switch_pressed.emit()
