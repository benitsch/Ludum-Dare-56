extends CharacterBody2D

@export var speed = 500
@export var gravity = 0

var started = false

func _physics_process(delta: float) -> void:
	if started: velocity.y += gravity * delta
	else: 
		started = true
		velocity.x = cos(rotation) * speed
		velocity.y = sin(rotation) * speed
	
	if gravity != 0:
		if velocity.y < 0: rotation_degrees = 270
		else: rotation_degrees = 90
	
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("Enemy"):queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Enemy"):queue_free()
