class_name BossStateChase extends BossState

var anim_name : String = "float"
@export var chase_speed : float = 40.0
@export var turn_rate : float = 0.25

@export_category("AI")
@export var detection_area : PlayerDetection
@export var damage_area : Hurtbox
@export var state_aggro_duration: float = 0.5
var next_state : BossState

@onready var idle: BossStateIdle = $"../Idle"


var _timer : float = 0.0
var _direction : Vector2
var _can_see_player : bool = false

func init() -> void:
	if detection_area:
		detection_area.player_entered.connect ( _on_player_enter )
		detection_area.player_exited.connect ( _on_player_exit )
	pass

func enter() -> void:
	print("state set chase")
	_timer = state_aggro_duration
	boss.update_animation(anim_name)
	if damage_area:
		damage_area.monitoring = true
	pass

func exit() -> void:
	_timer = 0
	if damage_area:
		damage_area.monitoring = false
	_can_see_player = false
	pass

func process(_delta : float) -> BossState:
	var new_dir : Vector2 = boss.global_position.direction_to( PlayerManager.player.global_position)
	_direction = lerp( _direction, new_dir, turn_rate )
	boss.velocity = _direction * chase_speed
	if boss.set_direction( _direction ):
		boss.update_animation( anim_name )
	
	
	
	if _can_see_player == false:
		next_state = idle
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
