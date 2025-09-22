class_name State_Walk extends State

@export var move_speed : float = 100.00
@onready var idle: State = $"../Idle"



func ready():
	pass
	
func Enter() -> void:
	player.UpdateAnimation("run")
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta: float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("run")
	return null
	
func Physics( _delta: float) -> State:
	player.velocity = Vector2.ZERO
	return null
	
func HandleInput (_event: InputEvent ) -> State:
	return null
