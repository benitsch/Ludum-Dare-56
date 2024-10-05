extends CharacterBody2D
class_name Player

@export var gravity = 3000
@export var jump_force = 800
@export var backlash_force = 750
@export var double_jump_force = 700
@export var speed = 700
@export var grav_jump_delay = 0.25
@export var double_jump = true
@export var zoom_factor = 0.65
@export var invincible_time = 1.0
@export var hp = 3

@onready var animated_sprite = $AnimatedSprite2D
@onready var camera : Camera2D = $Camera2D

var active = true
var grav_jump_timeout = 0.0
var can_double_jump = false
var allowed_to_double_jump = false
var backlash_X_force = 0.0
var coyote_time = 0.0
var invincible_timeout = 1.0

func _process(delta: float) -> void:
	# camera zoom
	var zoomChange 
	if Input.is_action_pressed("ZoomIn"):
		zoomChange = zoom_factor * delta
	elif Input.is_action_pressed("ZoomOut"):
		zoomChange = -zoom_factor * delta
	else:
		zoomChange = 0.0
	
	if zoomChange != 0.0:
		zoomChange = camera.get_zoom().x + zoomChange
		if zoomChange < 0.25: zoomChange = 0.25
		elif zoomChange > 1.0: zoomChange = 1.0
		camera.set_zoom(Vector2(zoomChange, zoomChange))
		camera.offset = Vector2(0, -500+300*zoomChange)
	
	if invincible_timeout > 0.0: invincible_timeout -= delta
	
	if grav_jump_timeout > 0:
		grav_jump_timeout -= delta
	
	if is_on_floor() == true:
		coyote_time = 0.25 
		if double_jump == true:
			can_double_jump = true
			allowed_to_double_jump = false
	elif coyote_time > 0.0:
		coyote_time -= delta
	
	# movment
	var direction = 0
	if active:
		if Input.is_action_pressed("jump"):
			if coyote_time > 0.0:
				coyote_time = 0.0
				jump(jump_force)
				grav_jump_timeout = grav_jump_delay
			elif is_on_floor() == false && can_double_jump == true && allowed_to_double_jump == true:
				can_double_jump = false
				jump(double_jump_force)
		elif grav_jump_timeout > 0.0:
			grav_jump_timeout = 0.0
		elif is_on_floor() == false && can_double_jump == true:
			allowed_to_double_jump = true
		
		direction = Input.get_axis("move_left","move_right")
	
	velocity.x = direction * speed
	if backlash_X_force != 0:
		if (velocity.x < 0.0 && backlash_X_force > 0.0) || (velocity.x > 0.0 && backlash_force < 0.0): 
			velocity.x = velocity.x * 0.25
		velocity.x += backlash_X_force
	
	# animation
	update_animations(direction)

func _physics_process(delta: float) -> void:	
	# gavity
	if is_on_floor() == false && grav_jump_timeout <= 0.0:
		velocity.y += gravity * delta
	
	if abs(backlash_X_force) > 100: backlash_X_force *= 0.75
	elif backlash_X_force != 0.0: backlash_X_force = 0.0
	
	move_and_slide()

func jump(force):
	velocity.y = -force
	AudioPlayer.play_sfx("jump")

func update_animations(direction):
	# set corret player sprite direction
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	# play corret player animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")

func _on_player_hit_area_hit_on_enemy(backlash: Vector2, dmg: float) -> void:
	velocity.y = backlash.y * backlash_force
	backlash_X_force += backlash.x * backlash_force
	if backlash_force != 0.0: velocity.x = 0.0

func _on_hit_area_area_entered(area: Area2D) -> void:
	if invincible_timeout > 0.0: return
	if area.is_in_group("Enemy"):
		hp -= 1
		if hp <= 0: queue_free()
		invincible_timeout = invincible_time
		
