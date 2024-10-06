class_name LevelSelectButton
extends SimpleButton

@export var levelNumber: int = -1;

func _ready() -> void:
    self.text = '%d' % levelNumber
    if levelNumber > -1:
        var levelString: String = '%02d' % levelNumber
        self.targetScenePath = 'res://scenes/levels/level_' + levelString + '.tscn'
    super._ready()
