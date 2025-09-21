class_name PushableBlock
extends CharacterBody2D

@onready var crateCollisionShape = $CollisionShape2D

var move_velocity = Vector2.ZERO
var move_target: Vector2

var push_distance = 16
var move_speed = 10

var is_sliding = false

func _ready():
	pass

func _physics_process(delta):
	if is_sliding:
		var remaining = move_target - global_position
		if remaining.length() < move_velocity.length() * delta:
			global_position = move_target
			move_velocity = Vector2.ZERO
			is_sliding = false
		else:
			move_and_collide(move_velocity * delta)
	
func try_to_push(direction: Vector2):
	if is_sliding:
		return
	
	move_target = global_position + direction * push_distance
	move_velocity = direction.normalized() * move_speed
	is_sliding = true
