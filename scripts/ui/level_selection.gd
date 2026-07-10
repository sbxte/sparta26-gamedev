extends Node

@export var sesh_left: RichTextLabel
@export var progress: TextureProgressBar

@export var ToMainMenu: TextureButton
@export var Easy: TextureButton
@export var Medium: TextureButton
@export var Hard: TextureButton
@export var FinalLevel: TextureButton
@export var click_sfx: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Final level stays locked until the 65 km bar is full — re-checked live in
	# case the bar fills while this screen is open.
	progress.value_changed.connect(_refresh_final_lock)
	_refresh_final_lock(progress.value)


func _refresh_final_lock(value: float) -> void:
	FinalLevel.disabled = value < progress.max_value

func _on_easy_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_medium_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_hard_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_final_pressed() -> void:
	AudioManager.play_sfx(click_sfx)
	EventManager.selected_difficulty = Constants.SessionDifficulty.EASY
	EventManager.easy.emit()


func _on_medium_pressed() -> void:
	EventManager.selected_difficulty = Constants.SessionDifficulty.NORMAL
	EventManager.normal.emit()


func _on_hard_pressed() -> void:
	EventManager.selected_difficulty = Constants.SessionDifficulty.HARD
	EventManager.hard.emit()


func _on_final_pressed() -> void:
	# No dedicated FINAL tier yet — use the hardest spawn rate for now.
	EventManager.selected_difficulty = Constants.SessionDifficulty.FINAL
	EventManager.final.emit()


func _on_back_pressed() -> void:
	AudioManager.play_sfx(click_sfx)
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
