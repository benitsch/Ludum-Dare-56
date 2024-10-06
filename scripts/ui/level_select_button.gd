class_name LevelSelectButton
extends SimpleButton

@export var levelNumber: int = -1;

func _init() -> void:
    self.alignment = HORIZONTAL_ALIGNMENT_CENTER

func _ready() -> void:
    if levelNumber > 0:
        var levelString: String = '%02d' % levelNumber
        self.targetScenePath = 'res://scenes/levels/level_' + levelString + '.tscn'
    super._ready()
