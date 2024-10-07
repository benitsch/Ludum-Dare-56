extends Node2D

@export var attack_delay = 3.0
@export var start_delay = -1.0

var shot_scene = preload("res://scenes/enemy/enemy_shot.tscn")

var attack_timeout = 0.0

func _ready() -> void:
	if start_delay == -1: attack_timeout = randf() * attack_delay
	else: attack_timeout = start_delay

func _process(delta: float) -> void:
	if attack_timeout > 0.0:
		attack_timeout -= delta
	else:
		attack_timeout = attack_delay
		var offset = randf_range(-5.0,5.0) 
		spawnShot(-10+offset)
		spawnShot(-5+offset)
		spawnShot(0+offset)
		spawnShot(5+offset)
		spawnShot(10+offset)

func AngleToRad(angle : float) -> float:
	return angle * PI / 180

func spawnShot(angle : float) -> void:
	var shot = shot_scene.instantiate()
	var radiant = AngleToRad(270+angle)
	var upDir = Vector2(cos(rotation+radiant), sin(rotation+radiant))
	shot.global_position = global_position + upDir * 50
	shot.rotation = rotation + radiant
	get_node("/root").add_child(shot)
	shot.speed *= 1.6
	shot.gravity = 750

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerHit"): 
		AudioPlayer.play_sfx("enemy_hit")
		queue_free()
