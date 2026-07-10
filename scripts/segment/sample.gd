extends Segment

## Used for determining the length of the segment. Gak harus actual background image :p
@export var background: Sprite2D

func init_segment(_ses: Session):
	pass

func destroy_segment():
	pass

func length() -> float:
	return background.texture.get_size().x
