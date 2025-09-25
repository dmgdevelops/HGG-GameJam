class_name BugStateStun extends BugState

@export var anim_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : BugState

var _direction : Vector2
var _animation_finished : bool = false


func init() -> void:
	bug.enemy_damaged.connect(_on_enemy_damaged)
	pass

func enter() -> void:
	_animation_finished = false
	#_direction = bug.DIR_4[rand]
	bug.set_direction(_direction)
	bug.velocity = _direction * -knockback_speed
	bug.update_animation(anim_name)
	pass

func exit() -> void:
	pass

func process(_delta : float) -> BugState:
	if _animation_finished == true:
		return next_state
	bug.velocity -= bug.velocity * decelerate_speed * _delta
	return null
	
func physics(_delta : float) -> BugState:
	return null

func _on_enemy_damaged():
	state_machine.change_state(self)
