extends CanvasLayer

var timer := Timer.new()


func _ready() -> void:
	timer.timeout.connect(_fade_out_message)
	timer.one_shot = true
	add_child(timer)
	timer.start(3)

func _fade_out_message():
	create_tween().tween_property(%Label, 'modulate:a', 0 , 2).finished.connect(_show_credits)
	print('credits')

func _show_credits():
	LevelManager.load_new_level('res://UI/title_screen.tscn')
	MenuButtons.show_credits_panel()
	MenuButtons.fade_out_credits()
	#%Credits.show()
	pass
