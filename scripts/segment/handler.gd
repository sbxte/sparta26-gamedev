class_name SegmentHandler
extends Node2D

@export var session: Session

@export_group("Segments")
@export var sample_segment: PackedScene
@export var sample_empty_segment: PackedScene

var last_segment: Segment

func _ready() -> void:
	last_segment = sample_empty_segment.instantiate()
	last_segment.position = Vector2.ZERO
	last_segment.init_segment(session)
	add_child(last_segment)
	while last_segment.position.x + last_segment.length() < get_viewport_rect().end.x:
		generate_next_segment()

func _process(_delta: float) -> void:
	# REVIEW: check if this is actually left most child, currently assuming FIFO on insertion and deletion
	var first: Segment = get_child(0)
	if first.position.x + first.length() < 0:
		first.destroy_segment()
		first.queue_free()
	
	var last: Segment = get_child(get_child_count() - 1)
	if last.position.x + last.length() < get_viewport_rect().end.x * 1.5:
		generate_next_segment()

func next_segment_packedscene() -> PackedScene:
	# TODO: Fill out with markov chain that gamedes will eventually make 
	return sample_segment

func generate_next_segment() -> void:
	var new_pos := last_segment.position
	new_pos.x += last_segment.length()

	var new_segment := next_segment_packedscene().instantiate()
	new_segment.position = new_pos
	new_segment.init_segment(session)
	add_child(new_segment)

	last_segment = new_segment
