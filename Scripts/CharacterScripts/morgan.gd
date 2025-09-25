class_name Player extends CharacterBody2D

@onready var Hurtbox = $Interactions/Hurtbox

@onready var Walkbox = $Walkbox

@onready var PushBox = $PushBox/PushBoxCollisionShape
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged( int_direction : Vector2 )

var speed = 100

var direction : Vector2 = Vector2.ZERO

var last_direction = Vector2.ZERO

var animated_sprite

var box_push_direction = Vector2.ZERO

var is_sliding = false

var slide_direction=Vector2.ZERO

var icetiles
var dirttiles

func _ready():
	animated_sprite = $AnimatedSprite2D
	PlayerManager.player = self
	state_machine.Initialize(self)
	icetiles = get_node_or_null("%IceTiles")
	dirttiles = get_node_or_null("%DirtTiles")

func _physics_process(delta):
	if is_sliding:
		slide(delta)
	else:
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		box_push_direction = direction
		
		move_and_slide()

func _on_push_box_body_entered(body):
	if body is PushableBlock:
		body.try_to_push(box_push_direction)

func start_sliding(s_direction:Vector2):
	is_sliding=true
	slide_direction=s_direction.normalized()
	last_direction=slide_direction
	UpdateAnimation("idle")
	
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

func SetDirection() -> bool:
	var new_dir : Vector2 = last_direction
	if direction == Vector2.ZERO:
		return false
	
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_dir = Vector2.UP if direction.y <0 else Vector2.DOWN
		
	if new_dir == last_direction:
		return false
		
	last_direction = new_dir
	DirectionChanged.emit( new_dir )
	animated_sprite.scale.x = -0.075 if last_direction == Vector2.LEFT else 0.075
	return true
	
func UpdateAnimation( state: String ) -> void:
	animated_sprite.play( state + "_" + AnimDirection() )
	pass
	
func AnimDirection() -> String:
	if last_direction == Vector2.DOWN:
		return "down"
	elif last_direction == Vector2.UP:
		return "up"
	else:
		return "right"
		
	
