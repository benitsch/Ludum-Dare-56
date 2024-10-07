extends Node

@export var volume: float = 0;

@onready var bg_music = $MusicPlayer

enum SCENE_SET {MENU, LEVEL, ENDSCREEN}
var current_scene = SCENE_SET.MENU

var hurt = preload("res://assets/audio/PLACEHOLDER-hurt.wav")
var jump = preload("res://assets/audio/PLACEHOLDER-jump.wav")
var attack = preload("res://assets/audio/attack.wav")

var menu = preload("res://assets/audio/Theme_Mix_2.0_Master.wav")
var level = preload("res://assets/audio/Action_Theme_Neu_Mix_1_Master.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "jump":
		stream = jump
	elif sfx_name == "hurt":
		stream = hurt
	elif sfx_name == "attack":
		stream = attack
	else:
		print("Invalid sfx name")
		return
	
	var asp = AudioStreamPlayer.new()
	asp.volume_db = volume
	asp.stream = stream
	asp.name = "SFX-"+sfx_name
	
	add_child(asp)
	
	asp.play()
	await asp.finished
	asp.queue_free()

func change_music(scene: int):
#TODO find correct position for volume set ->	bg_music.volume_db = volume
	if current_scene != scene:
		if scene == SCENE_SET.MENU:
			bg_music.stream = menu
		elif scene == SCENE_SET.LEVEL:
			bg_music.stream = level
		bg_music.play()
		current_scene = scene
