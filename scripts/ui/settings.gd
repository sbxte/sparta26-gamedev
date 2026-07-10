extends Node

@export var BGM_progress_bar: TextureProgressBar
@export var SFX_progress_bar: TextureProgressBar
@export var back_button: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	back_button.pivot_offset = back_button.size / 2

func _on_bgm_slider_value_changed(value: float) -> void:
	BGM_progress_bar.value = value

func _on_sfx_slider_value_changed(value: float) -> void:
	SFX_progress_bar.value = value

func _on_back_pressed() -> void:
	UiAnimManager.moveUpAnim(self, Vector2(0, -1080), 0.3)
