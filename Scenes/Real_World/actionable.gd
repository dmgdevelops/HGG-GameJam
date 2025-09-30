extends Area2D

@export var dialogue_title: String = "start"
@export var dialogue_box_manager: DialogueBoxManager

signal book_triggered_once


func action():
	if !dialogue_title or !dialogue_box_manager:
		printerr("actionable exports empty!")
	dialogue_box_manager.add_dialogue_box(dialogue_title)
	book_triggered_once.emit()
