extends Area2D

# show a sprite action
@export var item : Sprite2D

func action():
	if item.is_visible_in_tree():
		item.hide()
	else:
		item.show()
