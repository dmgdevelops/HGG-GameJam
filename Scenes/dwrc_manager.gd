extends Node


@onready var morgan = $"../Morgan"

func _ready():
	
	morgan.last_direction = Vector2i(0,-1)
