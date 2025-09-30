class_name DialogueBoxManager extends Node2D

@export var RootScene : Node
@export var Dialogue_Resource : DialogueResource

var DialogueNode = Node
var DialogueBox : Node
var tween


func _ready() -> void:
	if !RootScene or !Dialogue_Resource:
		printerr("Empty exports!")

	tween = get_tree()

func add_dialogue_box(p_title : StringName):
	DialogueNode = DialogueManager.show_dialogue_balloon(Dialogue_Resource, p_title)
	DialogueBox = DialogueNode.get_node('Balloon')
	DialogueBox.modulate.a = 0
	animate_dialogue_box()

func animate_dialogue_box(p_animation: StringName ='fade_in'):
	match p_animation:
		"fade_in":
			tween.create_tween().tween_property(DialogueBox, 'modulate:a', 1 , 0.5)
		"fade_out":
			tween.create_tween().tween_property(DialogueBox, 'modulate:a', 0 , 0.5)
