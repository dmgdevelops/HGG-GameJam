extends CanvasLayer

@onready var start_button = %Start

func _ready() -> void:
	start_button.connect('pressed', start_button_pressed)

func start_button_pressed():
	# add some code here
	print('started')
