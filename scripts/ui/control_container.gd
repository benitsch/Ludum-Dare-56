extends HBoxContainer

@export var keyString: String = 'K'
@export var descriptionString: String = '?'
@export var leftMarginOffset: int = 0

@onready var keyLabel: Label = %KeyLabel
@onready var descLabel: Label = %DescriptionLabel
@onready var indentHelper: MarginContainer = %IndentationHelper

func _ready() -> void:
    keyLabel.text = keyString
    descLabel.text = descriptionString
    indentHelper.add_theme_constant_override('margin_left', -65 + leftMarginOffset)
