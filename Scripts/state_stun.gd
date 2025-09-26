class_name State_Stun extends State

@export var knockback_speed : float = 100.00
@export var decelerate_speed : float = 20.00
@export var invul_duration : float = 1.0

var hurtbox : Hurtbox
var direction : Vector2

var next_state : State = null

@onready var idle: State = $"../Idle"


func init() -> void:
	player.PlayerDamaged.connect ( _player_damaged )

func ready():
	pass
	
func Enter() -> void:
	player.animated_sprite.animation_finished.connect( _animation_finished)
	
	direction = player.global_position.direction_to( hurtbox.global_position)
	player.velocity = direction * -knockback_speed
	player.SetDirection()
	player.UpdateAnimation("slash")
	
	player.make_invulnerable( invul_duration )
	player.effect_animator.play("Stun")
	pass
	
func Exit() -> void:
	next_state = null
	player.animated_sprite.animation_finished.disconnect(_animation_finished)
	pass
	
func Process( _delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	return next_state
	
func Physics( _delta: float) -> State:
	return null
	
func HandleInput (_event: InputEvent ) -> State:
	return null
	
func _player_damaged ( _hurtbox : Hurtbox ) -> void:
	hurtbox = _hurtbox
	state_machine.ChangeState(self)
	pass

func _animation_finished ( _a : String ) -> void:
	next_state = idle
	pass
