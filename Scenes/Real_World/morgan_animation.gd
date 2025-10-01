extends Node2D

@export var animation_tree : AnimationTree 
@onready var morgan = get_owner()

var last_facing_direction := Vector2(0, 1)

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	var idle = !morgan.velocity

	if !idle:
		last_facing_direction = morgan.velocity.normalized()

	animation_tree.set("parameters/MorganTidyState/Walk/blend_position", last_facing_direction)
	animation_tree.set("parameters/MorganTidyState/Idle/blend_position", last_facing_direction)
