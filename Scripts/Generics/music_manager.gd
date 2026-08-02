extends Node


@export var background_music = {
	&'ForestTheme' : 'res://Assets/MusicAndSFX/Forest Theme.ogg',
	&'DarkMorgan' : 'res://Assets/MusicAndSFX/Dark Morgan.ogg',
	&"Morgan'sRoom" : "res://Assets/MusicAndSFX/Morgan's Room (Real World - V2).ogg"
}

#@onready var audio_player = AudioStreamPlayer.new()

var current_music : AudioStreamPlayer
var current_music_string : StringName

func _ready() -> void:
	pass

func play_bg_music(p_music : StringName):
	#if !%AudioStreamPlayer.playing:
	#	%AudioStreamPlayer.stream = load( background_music[p_music] )
	#	%AudioStreamPlayer.play()

	var audio_player = AudioStreamPlayer.new()

	# check if current bgm is already playing
	if current_music_string == p_music:
		return

	if current_music != null:
		current_music.queue_free()
	

	current_music_string = p_music

	audio_player.stream = load(background_music[p_music])
	add_child(audio_player)
	audio_player.play()
	audio_player.bus = &'BGM'
	current_music = audio_player

func stop_bg_music():
	if current_music != null:
		current_music.stop()
