class_name PlayerUI
extends Control

@export var HP: Array[TextureRect]
@export var SusBar: TextureProgressBar
@export var EmptyHealthPath: String
@export var SpeedLabel: RichTextLabel
@export var DistanceLabel: RichTextLabel
@export var pause_node: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.player_hit.connect(_on_player_hit)

func _on_player_hit(health: int) -> void:
	if health == 0: return
	HP[len(HP) - health - 1].texture = load(EmptyHealthPath)

func _on_pause_pressed() -> void:
	pause_node.paused = not pause_node.paused
	AudioManager.play_sfx("res://assets/audio/sfx/CLICK.wav")
	pause_node.handle_pause()

# --- Session-driven readouts (the UI owns its own formatting) ---------
func update_speed(kmh: int) -> void:
	SpeedLabel.text = "%d km/h" % kmh

func update_distance(meters: int) -> void:
	DistanceLabel.text = "%d m/2400 m" % meters

func update_sus(percentage: float) -> void:
	SusBar.value = percentage
