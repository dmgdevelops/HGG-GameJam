extends CharacterBody2D

@onready var morgan_animations: AnimatedSprite2D = %Morgan_Animations
@onready var actionable_finder: Area2D = $Direction/Actionable_Finder

# real world Morgan spritesheet png is still a mess

# basic character movement I stole from the internet
@export var animation_player : AnimationPlayer
@export var speed := 200.0

var acceleration := 100.0
var last_facing_direction := Vector2(0, 1)


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")

	velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
	velocity.y = move_toward(velocity.y, direction.y * speed, acceleration) 

	move_and_collide(velocity * delta)

	if velocity:
		last_facing_direction = velocity.normalized()
	
	var animation_direction : String

	if last_facing_direction.x > 0:
		animation_direction = "right"
	elif last_facing_direction.x < 0:
		animation_direction = "left"
	elif last_facing_direction.y > 0:
		animation_direction = "down"
	elif last_facing_direction.y < 0:
		animation_direction = "up"
	
#	if velocity:
#		animation_player.play("walk" + animation_direction)



func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		
		if actionables.size() > 0:
			actionables[0].action()
			print("light_switch_pressed")
		print("enter_pressed")
