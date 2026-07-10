extends Control

## Shared by result_win.tscn and result_lose.tscn. The win/lose flavour lives in
## each scene's own art and text; this just fills the stat values (right column)
## from the run EventManager snapshotted, and wires the two buttons.

@export_group("Stat values")
@export var distance_value: RichTextLabel   ## this run's distance
@export var session_value: RichTextLabel    ## which session out of the max
@export var progress_value: RichTextLabel   ## total km toward the 65 km goal
@export var pace_value: RichTextLabel        ## average speed this run

@export_group("Buttons")
@export var run_again: TextureButton
@export var level_select: TextureButton

func _ready() -> void:
	run_again.pivot_offset = run_again.size / 2.0
	level_select.pivot_offset = level_select.size / 2.0

	distance_value.text = "%.2f km" % EventManager.last_run_km
	session_value.text = "%d / %d" % [EventManager.current_session, EventManager.max_sessions]
	progress_value.text = "%.1f / %.0f km" % [EventManager.total_km, EventManager.target_total]
	pace_value.text = "%.1f km/h" % EventManager.last_run_pace

func _on_run_again_pressed() -> void:
	AudioManager.play_sfx("res://assets/audio/sfx/CLICK.wav")
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")

func _on_level_select_pressed() -> void:
	AudioManager.play_sfx("res://assets/audio/sfx/CLICK.wav")
	get_tree().change_scene_to_file("res://scenes/level_selection.tscn")
