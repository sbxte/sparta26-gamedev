class_name Session
extends Node2D

@export var segment_handler: SegmentHandler

# TODO: Implement boost (with acceleration) and link up the UI event to here using Godot signals
var speed: float = 200.0

# TODO: track speed over time in graph

func _physics_process(delta: float) -> void:
	# Session handles segment movement on the possibility we will need to
	# halt movement temporarily maybe due to a power up / animation, or for some
	# other more advanced movement shenanigans. tldr future expandability. 
	segment_handler.move_children(speed * delta)

func init_session(_difficulty: int) -> void:
	# TODO: difficulty param is just a placeholder. The point is to accept difficulty information from level selection menu and adjust the session accordingly.
	# e.g. setting speed
	speed = 20.0
