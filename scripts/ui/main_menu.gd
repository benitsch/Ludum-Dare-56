extends Control

signal start_game()

@export var startButton: NodePath;

func _ready() -> void:
	var startButtonNode = get_node(startButton)
	if startButtonNode is Button:
		startButtonNode.grab_focus()

func _on_start_button_pressed() -> void:
	start_game.emit()
	hide()
