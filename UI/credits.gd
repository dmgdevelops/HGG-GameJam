extends CanvasLayer

signal credits_exited

#func _ready() -> void:
#	%LinkButton.pressed.connect(go_to_link.bind(%LinkButton.name))
#
#func go_to_link(p_name : String):
#	match p_name:
#		'LinkButton':
#			OS.shell_open('https://x.com/pipopubebu/status/2081408004256375240?s=20')
#			# can be file path
#	print(p_name)


func _unhandled_input(_event: InputEvent) -> void:
	get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed("exit_credits"):
		if !self.visible:
			return
		else:
			self.hide()
			credits_exited.emit()
