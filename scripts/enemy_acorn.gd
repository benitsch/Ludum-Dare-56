extends Node2D

@export var attackspeed = 2

var shot_scene = preload("res://scenes/enemy/enemy_shot.tscn")

var playerNode : Node2D
var attack_timeout = 0.0

func _process(delta: float) -> void:
	if attack_timeout > 0.0:
		attack_timeout -= delta
		return
	
	if playerNode == null: return
	
	attack_timeout = attackspeed
	var shot : Node2D = shot_scene.instantiate()
	get_node("/root").add_child(shot)
	shot.global_position = global_position
	shot.look_at(playerNode.global_position + Vector2(0, -100))

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerHit"): queue_free()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): playerNode = body

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body == playerNode: playerNode = null
