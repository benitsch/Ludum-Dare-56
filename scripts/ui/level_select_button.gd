class_name LevelSelectButton
extends TextureButton

@export var levelNumber: int = -1;
@onready var levelLabel: Label = $LevelLabel

func _ready() -> void:
    self.levelLabel.text = '%d' % levelNumber
    self.pressed.connect(_on_button_pressed)

    
func _on_button_pressed() -> void:
    if levelNumber < 0:
        return

    var levelString: String = '%02d' % levelNumber
    var targetScenePath: String = 'res://scenes/levels/level_' + levelString + '.tscn'
    
    get_tree().change_scene_to_file(targetScenePath)
