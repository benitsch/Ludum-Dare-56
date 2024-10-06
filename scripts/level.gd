extends Node2D
class_name Level


@export var is_final_level: bool = false
@export var next_level: PackedScene = null

@onready var death_zone = $DeathZone
@onready var exit = $Exit
@onready var player = $Player
@onready var start = $Start
@onready var traps = $Traps



func _ready():
	reset_player(true)
	connect_traps()
	
	exit.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_death_zone_body_entered(body):
	if body is Player:
		reset_player()

func _on_trap_touched_player():
	reset_player()

func reset_player(first_reset:bool = false):
	if !first_reset:
		AudioPlayer.play_sfx("hurt")
	player.set_global_position(start.get_spawn_pos())
	player.set_velocity(Vector2.ZERO)

func connect_traps():
	# use group traps which is set for root nodes in trap scenes
	traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

# handles all level end stuff 
func _on_exit_body_entered(body):
	if body is Player:
		end_level()

func end_level():
	exit.animate()
	player.active = false
	await get_tree().create_timer(0.5).timeout
	exit.pause_animate()
	if is_final_level:
		ui_layer.show_win_screen(true)
	elif next_level != null:
		get_tree().change_scene_to_packed(next_level)
