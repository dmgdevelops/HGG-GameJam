extends Area2D

# show a sprite action
@export var item : Sprite2D
@export var fade_speed : float = 1.0

@export var morgan : CharacterBody2D

var tween 

func _ready() -> void:
	tween = get_tree()
	item.modulate.a = 0

func action():
	if item.modulate.a > 0:
		tween.create_tween().parallel().tween_property(item, "modulate:a", 0 , fade_speed)
		morgan.set_physics_process(true)
#		item.hide()
	else:
		tween.create_tween().parallel().tween_property(item, "modulate:a", 1 , fade_speed)
		morgan.set_physics_process(false)
#		item.show()
