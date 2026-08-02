class_name SaveData extends Resource


enum menu_stages_state { LOCKED, UNLOCKED }

@export var first_launch :bool =  true

@export var DreamWorld = menu_stages_state.LOCKED

@export var DreamWorld_door1 = menu_stages_state.LOCKED
@export var DreamWorld_door2 = menu_stages_state.LOCKED
@export var DreamWorld_door3 = menu_stages_state.LOCKED
@export var DreamWorld_boss = menu_stages_state.LOCKED

@export var RealWorld = menu_stages_state.LOCKED
@export var RealWorld2 = menu_stages_state.LOCKED

@export var MusicSettings := 0.5
@export var Fullscreen := false
@export var KeyboardControlMenu:= true
