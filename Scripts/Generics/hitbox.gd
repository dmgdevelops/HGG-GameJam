class_name Hitbox extends Area2D

signal Damaged ( hurtbox : Hurtbox )

func _ready() -> void:
	pass
	
func _process( _delta: float) -> void:
	pass
	
func TakeDamage( hurtbox : Hurtbox ) -> void:
	Damaged.emit( hurtbox )
