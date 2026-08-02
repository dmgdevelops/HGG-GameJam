extends Area2D

signal action_triggered

func action():
	action_triggered.emit()
	print('act')
