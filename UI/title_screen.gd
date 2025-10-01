extends CanvasLayer

@onready var start_button = %Start

func _ready() -> void:
	start_button.connect('pressed', start_button_pressed)

func start_button_pressed():
	# add some code here
	LevelManager.load_new_level("res://Scenes/Real_World/real_world_untidy2.tscn")
	print('started')
	
