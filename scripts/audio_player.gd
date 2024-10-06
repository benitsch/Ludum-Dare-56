extends Node

@export var volume: float = 0;

@onready var bg_music = $MusicPlayer

enum SCENE_SET {MENU, LEVEL, ENDSCREEN}

var hurt = preload("res://assets/audio/PLACEHOLDER-hurt.wav")
var jump = preload("res://assets/audio/PLACEHOLDER-jump.wav")

func play_sfx(sfx_name: String):
	var stream = null
	if sfx_name == "jump":
		stream = jump
	elif sfx_name == "hurt":
		stream = hurt
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

# func change_music()
