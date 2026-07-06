extends Node

@export var run_again: TextureButton
@export var level_select: TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	run_again.pivot_offset = run_again.size / 2.0
	level_select.pivot_offset = level_select.size / 2.0

func _on_run_again_pressed() -> void:
	get_tree().change_scene_to_file("")  # probably just reload it by.. changing the scene to the current one


func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")
