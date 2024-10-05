extends Button

func _init() -> void:
    self.alignment = HORIZONTAL_ALIGNMENT_LEFT

func _ready() -> void:
    self.mouse_entered.connect(_on_button_mouse_entered)

func _on_button_mouse_entered() -> void:
    grab_focus()
