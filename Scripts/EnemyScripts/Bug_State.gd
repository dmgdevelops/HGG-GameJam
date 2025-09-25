class_name BugState extends Node


#Stores a reference to the enemy that this state belongs to
var bug:Bug
var state_machine: BugStateMachine

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func process(_delta : float) -> BugState:
	return null
	
func physics(_delta : float) -> BugState:
	return null
