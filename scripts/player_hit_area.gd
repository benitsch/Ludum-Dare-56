extends Node2D

@export var attack_delay = 0.5
@export var attack_dmg = 1.0

@onready var animator = $AnimationPlayer

var can_attack = true
var attack_timeout = 0.0
var backlash = Vector2(0, 0)
signal hit_on_enemy(backlash : Vector2, dmg : float)

func _process(delta):
	if attack_timeout > 0: attack_timeout -= delta
	
	if Input.is_action_pressed("attack_up"):
		if can_attack == false || attack_timeout > 0: return
		rotation_degrees = 270
		backlash = Vector2.DOWN
	elif Input.is_action_pressed("attack_right"):
		if can_attack == false || attack_timeout > 0: return
		rotation_degrees = 0
		backlash = Vector2.LEFT
	elif Input.is_action_pressed("attack_left"):
		if can_attack == false || attack_timeout > 0: return
		rotation_degrees = 180
		backlash = Vector2.RIGHT
	elif Input.is_action_pressed("attack_down"):
		if can_attack == false || attack_timeout > 0: return
		rotation_degrees = 90
		backlash = Vector2.UP
	else:
		can_attack = true  
		return
	
	can_attack = false
	attack_timeout = attack_delay
	animator.play("fade")

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		hit_on_enemy.emit(backlash, attack_dmg)
