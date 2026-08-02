extends CanvasLayer

@onready var start_button = %Start


func _ready() -> void:
	start_button.connect('pressed', start_button_pressed)
	%MainMenu.connect('pressed', open_main_menu) 

	MusicManager.stop_bg_music()

	if OS.get_name() == 'Web':
		%Quit.modulate.a = 0
		%Quit.disabled = true
		return
	%Quit.connect('pressed', quit_game)

func start_button_pressed():
	# add some code here
	LevelManager.load_new_level("res://Scenes/Real_World/real_world_untidy2.tscn")
	print('started')

func open_main_menu():
	MenuButtons.show()

func quit_game():
	get_tree().quit()
