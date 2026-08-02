extends CanvasLayer

@export var character_sprite_path : String
@export var character_player : CharacterBody2D
@export var fade_speed : float = 0.5



func _ready():
	if character_player or character_sprite_path == null:
		printerr('sprite exports empty!')
	%Sprite2D.texture = load(character_sprite_path)
	character_player = PlayerManager.player
	%SpriteControl.modulate.a = 0
	%DialogueOverlay.modulate.a = 0 
	pass


func fade_in(): 
	var tween = get_tree().create_tween()
	%Sprite2D.create_tween().parallel().tween_property(%SpriteControl, "modulate:a", 1 , fade_speed)
	tween.parallel().tween_property(%DialogueOverlay, "modulate:a", 1 , fade_speed)
	character_player.set_physics_process(false)

func fade_out(): 
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(%SpriteControl, "modulate:a", 0 , fade_speed)
	tween.parallel().tween_property(%DialogueOverlay, "modulate:a", 0 , fade_speed)
	character_player.set_physics_process(true)

func fade_out_character_only():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(%SpriteControl, "modulate:a", 0 , fade_speed)


# hardcoded character sprite dialogues :skull:

func sword_acquired():
	%Sword.show()
	%Sprite2D.hide()

func show_dark_morgan():
	if %Sprite2D.is_visible_in_tree():
		%Sprite2D.hide()
	%DarkMorgan.show()

func hide_dark_morgan():
	%DarkMorgan.hide()

func show_morgan():
	%Sword.hide()
	%Sprite2D.show()
