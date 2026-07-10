extends Node

@export var ToMainMenu: TextureButton
@export var Easy: TextureButton
@export var Medium: TextureButton
@export var Hard: TextureButton
@export var FinalLevel: TextureButton
@export var click_sfx: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_easy_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_medium_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_hard_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_final_pressed() -> void:
	AudioManager.play_sfx(click_sfx)


func _on_back_pressed() -> void:
	AudioManager.play_sfx(click_sfx)
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
