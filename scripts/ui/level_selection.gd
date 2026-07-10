extends Node

@export var sesh_left: RichTextLabel
@export var progress: TextureProgressBar

@export var ToMainMenu: TextureButton
@export var Easy: TextureButton
@export var Medium: TextureButton
@export var Hard: TextureButton
@export var FinalLevel: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Final level stays locked until the 65 km bar is full.
	FinalLevel.disabled = progress.value < progress.max_value


func _on_easy_pressed() -> void:
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
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
