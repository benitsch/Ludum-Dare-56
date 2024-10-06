extends Control

@onready var grid: GridContainer = %LevelGrid

var levelCount: int = 7
var scene: Resource = preload('res://scenes/ui/level_select_button.tscn')

func _ready() -> void:
    if levelCount < 1:
        return

    for nLevel in range(1, levelCount + 1):
        var instance = scene.instantiate()
        if instance is LevelSelectButton:
            instance.levelNumber = nLevel
        grid.add_child(instance)
