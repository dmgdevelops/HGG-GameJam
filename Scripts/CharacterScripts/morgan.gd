extends CharacterBody2D

@onready var Hurtbox = $Hurtbox

@onready var Walkbox = $Walkbox

@onready var PushBox = $PushBox/PushBoxCollisionShape


var speed = 100

var last_direction = Vector2.ZERO

var animated_sprite

var box_push_direction = Vector2.ZERO

var is_sliding = false

var slide_direction=Vector2.ZERO

var icetiles
var dirttiles

func _ready():
	animated_sprite = $AnimatedSprite2D
	icetiles = get_node_or_null("%IceTiles")
	dirttiles = get_node_or_null("%DirtTiles")

func _physics_process(delta):
	if is_sliding:
		slide(delta)
	else:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		box_push_direction = direction
		
		velocity = direction * speed
		
		if direction != Vector2.ZERO:
			last_direction = direction
		
		if direction.x != 0:
			animated_sprite.play("run_right")
		elif direction.y < 0:
			animated_sprite.play("run_up")
		elif direction.y > 0:
			animated_sprite.play("run_down")
		else:
			if last_direction.x != 0:
				animated_sprite.play("idle_right")
			elif last_direction.y < 0:
				animated_sprite.play("idle_up")
			elif last_direction.y > 0:
				animated_sprite.play("idle_down")
		
		animated_sprite.flip_h = last_direction.x < 0
		
		move_and_slide()

func _on_push_box_body_entered(body):
	if body is PushableBlock:
		body.try_to_push(box_push_direction)

func start_sliding(direction:Vector2):
	is_sliding=true
	slide_direction=direction.normalized()
	
func slide(delta):
	velocity = slide_direction * speed
	var collision = move_and_collide(velocity*delta)
	
	if collision:
		stop_sliding()
		return
	
	var local_position_morgan = Walkbox.global_position
	var current_tile_coordinates = icetiles.local_to_map(local_position_morgan)
	var tile_id_ice = icetiles.get_cell_source_id(current_tile_coordinates)
	var tile_id_dirt= dirttiles.get_cell_source_id(current_tile_coordinates)
	
	if tile_id_dirt != -1:
		stop_sliding()
	elif tile_id_ice == -1:
		stop_sliding()
	

func stop_sliding():
	is_sliding = false
	velocity = Vector2.ZERO
