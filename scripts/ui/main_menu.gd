extends Node

@export var button_array: Array[TextureButton]
@export var settings: Node
@export var BGMPath: String
@export var ClickSound: String

# 0 = play, 1 = settings, 2 = quit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_bgm(BGMPath)
	for i in range(len(button_array)):
		button_array[i].pressed.connect(_on_button_pressed.bind(i))

func _on_button_pressed(idx: int) -> void:
	AudioManager.play_sfx(ClickSound)
	match idx:
		0: get_tree().change_scene_to_file("res://scenes/level_selection.tscn")
		1: UiAnimManager.moveDownAnim(settings, Vector2.ZERO, 0.3)
		2: get_tree().quit() # or handle save..
