extends Node2D

@onready var actionable: Area2D = $stage/table/actionable
@onready var light_switch_shader: CanvasLayer = $Light_switch_shader


func _ready() -> void:
	actionable.connect('light_switch_pressed', light_switch)

func light_switch():
	if !light_switch_shader.visible:
		light_switch_shader.show()
	else:
		light_switch_shader.hide()
