class_name BossState extends Node


#Stores a reference to the enemy that this state belongs to
var boss : Boss
var state_machine: BossStateMachine

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta : float) -> BossState:
	return null
	
func physics(_delta : float) -> BossState:
	return null
