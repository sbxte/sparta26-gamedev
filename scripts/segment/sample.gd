extends Segment

## Used for determining the length of the segment. Gak harus actual segment_length image :p
@export var segment_length: int
@export var segment_name: String

func init_segment(_ses: Session):
	pass

func destroy_segment():
	pass

func length() -> float:
	return segment_length
