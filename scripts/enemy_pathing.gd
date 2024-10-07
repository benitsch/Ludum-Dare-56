extends Path2D

@export var startPos = 0.0
@export var speed = 200

@onready var path = $Path

var dir;

func _ready() -> void:
	dir = 1
	path.progress_ratio = clampf(startPos, 0.0, 1.0)

func _physics_process(delta: float) -> void:
	path.progress += speed * delta * dir
	if path.progress_ratio == 0 || path.progress_ratio == 1: dir = -dir


func _on_child_exiting_tree(_node: Node) -> void:
	AudioPlayer.play_sfx("enemy_hit")
	queue_free()
