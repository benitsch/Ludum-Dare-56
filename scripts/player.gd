extends CharacterBody2D
class_name Player

@export var gravity = 1500
@export var jump_force = 350
@export var double_jump_force = 450
@export var speed = 200
@export var coyote_jump_time = 0.25
@export var double_jump = false

@onready var animated_sprite = $AnimatedSprite2D

var active = true
var coyote_timeout = 0.0
var can_double_jump = false
var allowed_to_double_jump = false

func _process(delta):
	if coyote_timeout > 0:
		coyote_timeout -= delta
	
	if is_on_floor() == true && double_jump == true:
		can_double_jump = true
		allowed_to_double_jump = false
	
	# gavity
	if is_on_floor() == false && coyote_timeout <= 0.0:
		velocity.y += gravity * delta
		#if velocity.y >= 500 :
		#	velocity.y = 500
	
	# movment
	var direction = 0
	if active:
		if Input.is_action_pressed("jump"):
			if is_on_floor():
				jump(jump_force)
				coyote_timeout = coyote_jump_time
			#elif coyote_timeout > 0:
			#	jump(jump_force)
			elif can_double_jump == true && allowed_to_double_jump == true:
				can_double_jump = false
				jump(double_jump_force)
		elif coyote_timeout > 0.0:
			coyote_timeout = 0.0
		elif is_on_floor() == false && can_double_jump == true:
			allowed_to_double_jump = true
		
		direction = Input.get_axis("move_left","move_right")
		
	velocity.x = direction * speed
	
	move_and_slide()
	
	
	# animation
	update_animations(direction)


func jump(force):
	velocity.y = -force
	AudioPlayer.play_sfx("jump")


func update_animations(direction):
	# set corret player sprite direction
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	# play corret player animation
	if is_on_floor():
		if direction == 0 :
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
