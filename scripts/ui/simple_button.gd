class_name SimpleButton

extends Button

@export_file('*.tscn') var targetScenePath: String = ''

func _init() -> void:
	self.alignment = HORIZONTAL_ALIGNMENT_LEFT

func _ready() -> void:
	self.mouse_entered.connect(_on_button_mouse_entered)
	self.pressed.connect(_on_button_pressed)

func _on_button_mouse_entered() -> void:
	grab_focus()
	
func _on_button_pressed() -> void:
	if targetScenePath == '':
		return
	
	get_tree().change_scene_to_file(targetScenePath)
