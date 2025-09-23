class_name State_Attack extends State

@export_range(1,20, 0.5) var decelerate_speed : float = 5.0

@onready var walk: State_Walk = $"../Walk"
@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var idle: State_Idle = $"../Idle"
@onready var hurtbox: Hurtbox = $"../../Interactions/Hurtbox"



var isAttacking : bool = false

func ready():
	pass
	
func Enter() -> void:
	player.UpdateAnimation("slash")
	animated_sprite.animation_finished.connect( EndAttack )
	isAttacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurtbox.monitoring = true
	pass
	
func Exit() -> void:
	animated_sprite.animation_finished.disconnect( EndAttack )
	isAttacking = false
	hurtbox.monitoring = false
	pass
	
func Process( _delta: float) -> State:
	return null
	
func Physics( _delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if isAttacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else: 
			return walk
	return null
	
func HandleInput (_event: InputEvent ) -> State:
	return null

func EndAttack() -> void:
	isAttacking = false
