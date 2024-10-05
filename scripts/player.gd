extends CharacterBody2D
class_name Player

@export var gravit = 400
@export var jump_force = 250
@export var speed = 125

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _process(delta):
	# gavity
	if is_on_floor()==false:
		velocity.y += gravit *delta
		if velocity.y >= 500 :
			velocity.y = 500
	
	
	# movment
	var direction = 0
	if active:
		if Input.is_action_pressed("jump") && is_on_floor():
			jump(jump_force)
		
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
