class_name Boss extends CharacterBody2D

signal direction_changed(new_direction : Vector2)
signal enemy_damaged( hurtbox: Hurtbox )

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp : int = 10

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false
#var _can_attack_player : bool = false

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox : Hitbox = $Hitbox
@onready var state_machine : BossStateMachine = $BossStateMachine
@onready var attack_detection: PlayerDetection = $AttackDetection


func _ready():
	state_machine.initialize(self)
	player = PlayerManager.player
	hitbox.Damaged.connect(_take_damage)
	#attack_detection.player_entered.connect( _on_attack_enter )
	#attack_detection.player_exited.connect( _on_attack_exit )
	pass
	
func _process( _delta):
	pass

func _physics_process(_delta):
	move_and_slide()
	

func set_direction(_new_direction:Vector2) -> bool:
	direction=_new_direction
	if direction == Vector2.ZERO:
		return false
	
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle()/TAU*DIR_4.size()))
	var new_dir = DIR_4[direction_id]
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	direction_changed.emit(new_dir)
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation(state:String) -> void:
	sprite.play(state + "_" + anim_direction())
	
	
func _take_damage( hurtbox : Hurtbox) -> void:
	hp -= hurtbox.damage
	print("took damage " + str(hp))
	if hp > 0:
		enemy_damaged.emit()
	else:
		self.queue_free()
		
func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

#func _on_attack_enter() -> void:
	#_can_attack_player = true
	#print("in range")
	#pass
	
#func _on_attack_exit() -> void:
	#_can_attack_player = false
	#print("left range")
	#pass
