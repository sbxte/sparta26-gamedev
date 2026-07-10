class_name Session
extends Node2D

@export var segment_handler: SegmentHandler

@export_category("Base Speed")
@export var speed_curve: Curve
@export var time_to_max_speed: float = 10.0
@export var max_speed: float = 200.0

@export_category("Player UI")
@export var player_ui: Node

@export_category("Boost")
@export var boost_amount: float
@export var boost_ramp: float

@export_category("Sus Bar")
@export var sus_rate: float = 25.0
@export var sus_decay: float = 15.0
@export var sus_max: float = 100.0

@export var units_to_kmh: float = 0.5
# NOTE: change into actual translation of km ingame later

var is_running: bool

# TODO: Implement boost (with acceleration) and link up the UI event to here using Godot signals
static var speed: float = 0.0
static var is_boosting: bool
static var sus_percentage: float = 0.0

var running_time: float
var step: float = 0.0
var _boost_factor: float = 0.0

var distance_tracker: RichTextLabel
var speed_label: RichTextLabel
var sus_bar: TextureProgressBar

func _ready() -> void:
	distance_tracker = player_ui.DistanceLabel
	speed_label = player_ui.SpeedLabel
	sus_bar = player_ui.SusBar
# Set from the level-select choice, persisted on the EventManager autoload.
# Member init runs before any _ready, so this is set before SegmentHandler._ready
# reads it to spawn the opening segments.
var difficulty := EventManager.selected_difficulty

func _physics_process(delta: float) -> void:
	# Session handles segment movement on the possibility we will need to
	# halt movement temporarily maybe due to a power up / animation, or for some
	# other more advanced movement shenanigans. tldr future expandability.
	if not is_running:
		running_time = 0
		speed = 0  
		is_boosting = false
		_boost_factor = 0.0
		segment_handler.move_children(speed * delta) # Force stops, even if boosting
		return
	
	# Base Speed
	var base_speed := lerpf(0.0, max_speed, speed_curve.sample_baked(running_time / time_to_max_speed))
	running_time = min(running_time + delta, time_to_max_speed)
	
	# Boost
	# NOTE: Add boost button later
	var holding := Input.is_action_pressed("boost")
	var target := boost_amount if holding else 0.0
	_boost_factor = move_toward(_boost_factor, target, boost_ramp * delta)
	speed = base_speed * (1.0 + _boost_factor)

	# Sus bar
	if holding:
		sus_percentage = min(sus_percentage + sus_rate * delta, sus_max)
	else:
		sus_percentage = max(sus_percentage - sus_decay * delta, 0.0)

	# Boosting afterimages, sfx
	if holding != is_boosting:
		is_boosting = holding
		if is_boosting:
			EventManager.boost_started.emit()
		else:
			EventManager.boost_ended.emit()
	
	if sus_percentage >= sus_max:
		_end_run()
		return
	
	step += speed * delta
	segment_handler.move_children(step)
	distance_tracker.text = "%d m/2400 m" % roundi(step)
	sus_bar.value = sus_percentage

func _process(_delta: float) -> void:
	if is_running:
		speed_label.text = "%d km/h" % roundi(speed * units_to_kmh)
	

func _end_run() -> void:
	is_running = false
	is_boosting = false
	EventManager.end_sesh.emit()

func init_session(_difficulty: int) -> void:
	# TODO: difficulty param is just a placeholder. The point is to accept difficulty information from level selection menu and adjust the session accordingly.
	# e.g. setting speed
	speed = 20.0
	EventManager.session_ready.emit()
