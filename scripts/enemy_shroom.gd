extends Node2D

var animator : AnimatedSprite2D

func _ready() -> void:
	animator = $AnimatedSprite2D
	
	if get_parent().is_class("PathFollow2D"): animator.play("move")
	else: animator.play("default")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayerHit"): queue_free()
