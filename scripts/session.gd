class_name Session
extends Node2D

@export var segment_handler: SegmentHandler
@export var speed_curve: Curve 
@export var time_to_max_speed: float = 10.0
@export var max_speed: float = 200.0

var is_running: bool

# TODO: Implement boost (with acceleration) and link up the UI event to here using Godot signals
static var speed: float = 0.0
var running_time: float
# TODO: track speed over time in ui (km/h)

func _physics_process(delta: float) -> void:
	# Session handles segment movement on the possibility we will need to
	# halt movement temporarily maybe due to a power up / animation, or for some
	# other more advanced movement shenanigans. tldr future expandability. 
	if is_running:
		speed = lerpf(0.0, max_speed, speed_curve.sample_baked(running_time / time_to_max_speed))
		running_time = min(running_time + delta, time_to_max_speed)
	elif not is_running:
		running_time = 0
		speed = 0 # or you could handle it somewhere
	
	segment_handler.move_children(speed * delta)
	

func init_session(_difficulty: int) -> void:
	# TODO: difficulty param is just a placeholder. The point is to accept difficulty information from level selection menu and adjust the session accordingly.
	# e.g. setting speed
	speed = 20.0
	EventManager.session_ready.emit()
