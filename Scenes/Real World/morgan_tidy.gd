extends CharacterBody2D

@onready var morgan_animations: AnimatedSprite2D = %Morgan_Animations
@onready var actionable_finder: Area2D = $Direction/Actionable_Finder

# real world Morgan spritesheet png is still a mess

# basic character movement I stole from the internet
@export var speed := 200.0

var last_direction = Vector2.ZERO
var acceleration := 100.0

var animation_direction := "down"
var animation_state := "idle_down"

func update_sprite_direction(input: Vector2):
	match input:
		Vector2.DOWN:
			animation_direction = "down"	
		Vector2.UP:
			animation_direction = "up"	
		Vector2.RIGHT:
			animation_direction = "right"	
		Vector2.LEFT:
			animation_direction = "left"	

func update_sprite():
	if velocity.length() > 0:
		animation_state = "walk_"
	else:
		animation_state = "idle_"

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	update_sprite_direction(direction)
	update_sprite()

	morgan_animations.play(animation_state + animation_direction)

	velocity.x = move_toward(velocity.x, direction.x * speed, acceleration  )
	velocity.y = move_toward(velocity.y, direction.y * speed, acceleration  )

	move_and_collide(velocity*delta)


# Player Input for interactions
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		
		if actionables.size() > 0:
			actionables[0].action()
		print("enter_pressed")
