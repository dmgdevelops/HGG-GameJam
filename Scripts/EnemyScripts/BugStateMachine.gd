class_name BugStateMachine extends Node


var states : Array[BugState]
var prev_state: BugState
var current_state: BugState

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass
	
	
func _process(delta):
	change_state(current_state.process(delta))
	pass

func _physics_process(delta):
	change_state(current_state.physics(delta))

func initialize(_bug:Bug) -> void:
	states = []
	
	for c in get_children():
		if c is BugState:
			states.append(c)
	
	for s in states:
		s.bug = _bug
		s.state_machine = self
		s.init()
		
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func change_state(new_state : BugState) -> void:
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
