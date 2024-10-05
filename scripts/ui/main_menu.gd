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

func _on_settings_button_pressed() -> void:
    pass # Replace with function body.

func _on_level_select_button_pressed() -> void:
    pass # Replace with function body.


func _on_credits_button_pressed() -> void:
    pass # Replace with function body.
