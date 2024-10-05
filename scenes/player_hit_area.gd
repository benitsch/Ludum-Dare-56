extends Node2D

@export var attack_delay = 0.3

@onready var animator = $AnimationPlayer

var attack_timeout = 0.0

func _process(delta):
	if attack_timeout > 0:
		attack_timeout -= delta
		return
	
	if Input.is_action_pressed("attack_up"):
		rotation_degrees = 270
	elif Input.is_action_pressed("attack_right"):
		rotation_degrees = 0
	elif Input.is_action_pressed("attack_left"):
		rotation_degrees = 180
	elif Input.is_action_pressed("attack_down"):
		rotation_degrees = 90
	else: 
		return
	
	attack_timeout = attack_delay
	animator.play("fade")


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
