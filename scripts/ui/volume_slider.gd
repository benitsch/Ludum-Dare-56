extends HSlider

var can_play_sound: bool = true

func _ready() -> void:
    var timer = get_node("Timer")
    timer.timeout.connect(_on_timer_timeout)
    self.value = AudioPlayer.volume
    
    self.value_changed.connect(_on_volume_value_changed)
    
func _on_timer_timeout() -> void:
    print('timeout')
    self.can_play_sound = true

func _on_volume_value_changed(value: float) -> void:
    AudioPlayer.volume = value
    if self.can_play_sound == true:
        self.can_play_sound = false
        AudioPlayer.play_sfx("jump")
