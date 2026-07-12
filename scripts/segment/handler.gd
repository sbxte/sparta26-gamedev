class_name SegmentHandler
extends Node2D

@export var session: Session

@export_group("Segments")
@export_file("*.tscn") var itb_segment: String
@export_file("*.tscn") var unpad_segment: String
@export_file("*.tscn") var jatos_segment: String
@export_file("*.tscn") var aa_segment: String
@export_file("*.tscn") var griya_segment: String
@export_file("*.tscn") var warteg_segment: String
@export_file("*.tscn") var filler1_segment: String
@export_file("*.tscn") var filler2_segment: String
@export_file("*.tscn") var filler3_segment: String
@export_file("*.tscn") var bush_segment: String

var last_segment: Segment
var last_segment_idx := 0

func _ready() -> void:
	last_segment = load(itb_segment).instantiate()
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
	last_segment_idx += 1

	# TODO: cross road segments
	var loop: Array
	if session.difficulty == Constants.SessionDifficulty.EASY:
		loop = [
			itb_segment,
			filler3_segment,
			bush_segment,
			filler1_segment,
			filler2_segment,

			jatos_segment,
			filler3_segment,
			bush_segment,

			aa_segment,
			filler3_segment,

			griya_segment,
			bush_segment,
			filler1_segment,

			warteg_segment,
			filler2_segment,
			bush_segment,
			filler1_segment,
			]
	elif session.difficulty == Constants.SessionDifficulty.NORMAL:
		loop = [
			itb_segment,
			filler3_segment,
			bush_segment,
			filler2_segment,
			bush_segment,
			bush_segment,
			filler3_segment,

			unpad_segment,
			filler2_segment,
			bush_segment,
			filler3_segment,
			filler2_segment,

			jatos_segment,
			filler3_segment,
			bush_segment,

			aa_segment,
			filler3_segment,

			griya_segment,
			bush_segment,
			filler1_segment,

			warteg_segment,
			filler2_segment,
			bush_segment,
			filler1_segment,
			]
	else:
		loop = [
			itb_segment,
			filler3_segment,
			bush_segment,
			filler2_segment,
			bush_segment,
			bush_segment,
			filler3_segment,

			unpad_segment,
			filler2_segment,
			bush_segment,
			filler3_segment,
			filler2_segment,

			jatos_segment,
			filler3_segment,
			bush_segment,

			aa_segment,
			filler3_segment,

			griya_segment,
			bush_segment,
			filler1_segment,

			warteg_segment,
			filler2_segment,
			bush_segment,
			filler3_segment,
			filler2_segment,
			bush_segment,
			filler1_segment,
			]
	
	last_segment_idx = last_segment_idx % loop.size()
	return load(loop[last_segment_idx])

func generate_next_segment() -> void:
	var new_pos := last_segment.position
	new_pos.x += last_segment.length()

	var new_segment := next_segment_packedscene().instantiate()
	new_segment.position = new_pos
	new_segment.init_segment(session)
	add_child(new_segment)

	last_segment = new_segment

func move_children(delta: float) -> void:
	for child: Segment in get_children():
		child.position.x -= delta
