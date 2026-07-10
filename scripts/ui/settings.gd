extends Node

@export var BGM_progress_bar: TextureProgressBar
@export var SFX_progress_bar: TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.bgm_volume = BGM_progress_bar.value / 100.0
	AudioManager.sfx_volume = SFX_progress_bar.value / 100.0
	
func _on_bgm_slider_value_changed(value: float) -> void:
	BGM_progress_bar.value = value
	AudioManager.bgm_volume = value / 100.0

func _on_sfx_slider_value_changed(value: float) -> void:
	SFX_progress_bar.value = value
	AudioManager.sfx_volume = value / 100.0

func _on_back_pressed() -> void:
	UiAnimManager.moveUpAnim(self, Vector2(0, -1080), 0.3)
