class_name BossStateChase extends BossState

@export var anim_name : String = "float"
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.25

@export_category("AI")
@export var detection_area : PlayerDetection
@export var attack_area : Hurtbox
@export var state_aggro_duration: float = 0.5
@export var next_state : BossState

var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false

func init() -> void:
	if detection_area:
		detection_area.player_entered.connect ( _on_player_enter )
		detection_area.player_exited.connect ( _on_player_exit )
	pass

func enter() -> void:
	_timer = state_aggro_duration
	boss.update_animation(anim_name)
	if attack_area:
		attack_area.monitoring = true
	#boss.velocity = _direction * wander_speed
	#boss.set_direction(_direction)
	pass

func exit() -> void:
	if attack_area:
		attack_area.monitoring = false
	_can_see_player = false
	pass

func process(_delta : float) -> BossState:
	var new_dir : Vector2 = boss.global_position.direction_to( PlayerManager.player.global_position)
	_direction = lerp( _direction, new_dir, turn_rate )
	boss.velocity = _direction * chase_speed
	if boss.set_direction( _direction ):
		boss.update_animation( anim_name )
	
	if _can_see_player == false:
		_timer -= _delta
		if _timer <= 0:
			return next_state
	else:
		_timer = state_aggro_duration
	return null
	
func physics(_delta : float) -> BossState:
	return null

func _on_player_enter() -> void:
	_can_see_player = true
	
	state_machine.change_state( self )
	pass
	
func _on_player_exit() -> void:
	_can_see_player = false
	pass
