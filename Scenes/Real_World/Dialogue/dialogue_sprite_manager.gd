class_name DialogueSpriteManager extends Node2D

@export var character_sprite : Sprite2D
@export var dialogue_overlay : Control
@export var fade_speed : float
@export var player : CharacterBody2D

# character sprite position
var center = DisplayServer.window_get_size().x / 2
var character_y_pos : int = 540

var overlay_pos := Vector2(-4, -83)

var tween


# animating dialogue character sprites
func _ready() -> void:
	tween = get_tree()

	dialogue_overlay.position = overlay_pos
	character_sprite.position.x = center
	character_sprite.position.y = character_y_pos
	dialogue_overlay.modulate.a = 0
	character_sprite.modulate.a = 0


func dialogue_insert(): pass

func fade_in(): 
	character_sprite.create_tween().parallel().tween_property(character_sprite, "modulate:a", 1 , fade_speed)
	tween.create_tween().parallel().tween_property(dialogue_overlay, "modulate:a", 1 , fade_speed)
	player.set_physics_process(false)

func fade_out(): 
	tween.create_tween().parallel().tween_property(character_sprite, "modulate:a", 0 , fade_speed)
	tween.create_tween().parallel().tween_property(dialogue_overlay, "modulate:a", 0 , fade_speed)
	player.set_physics_process(true)
