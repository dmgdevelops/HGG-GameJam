class_name BossStateAttack extends BossState

@export_range(1,20, 0.5) var decelerate_speed : float = 5.0

var isAttacking : bool = false
@export var hurtbox: Hurtbox 
@onready var idle: BossStateIdle = $"../Idle"
@onready var chase: BossStateChase = $"../Chase"




func ready():
	pass
	
func init() -> void:
	boss.attack_detection.player_entered.connect( DoAttack )
	pass
	
func Enter() -> void:
	print("state set attack")
	boss.update_animation("attack")
	print("attack processed")
	boss.sprite.animation_finished.connect( EndAttack )
	isAttacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurtbox.monitoring = true
	pass
	
func Exit() -> void:
	boss.sprite.animation_finished.disconnect( EndAttack )
	isAttacking = false
	hurtbox.monitoring = false
	pass
	
func Process( _delta: float) -> BossState:
	boss.velocity -= boss.velocity * decelerate_speed * _delta
	
	if isAttacking == false:
		return chase
	return null
	
func Physics( _delta: float) -> BossState:
	return null
	
func HandleInput (_event: InputEvent ) -> BossState:
	return null

func EndAttack() -> void:
	isAttacking = false

func DoAttack() -> void:
	state_machine.change_state(self)
