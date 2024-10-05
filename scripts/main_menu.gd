extends Control

signal start_game()

func _on_start_button_pressed() -> void:
    start_game.emit()
    hide()

func _on_settings_button_pressed() -> void:
    pass # Replace with function body.

func _on_level_select_button_pressed() -> void:
    pass # Replace with function body.

func do_the_focus(path) -> void:
    var node = get_node(path)
    node.grab_focus()

func _on_button_mouse_entered(btn) -> void:
    do_the_focus(btn)


func _on_start_button_ready(btn) -> void:
    do_the_focus(btn)
