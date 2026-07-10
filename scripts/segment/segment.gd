@abstract
class_name Segment
extends Node2D

# Accepts the session node to adjust segment generation based on session statistics
func init_segment(ses: Session) -> void:
	for child in get_children():
		if child is Obstacle:
			var chance: float = child.base_spawn_chance
			if ses.difficulty == Constants.SessionDifficulty.NORMAL:
				chance += 0.3
			elif ses.difficulty == Constants.SessionDifficulty.HARD:
				chance += 0.75
			elif ses.difficulty == Constants.SessionDifficulty.FINAL:
				chance += 0.9
			child.setup(ses, chance)

@abstract 
func destroy_segment()

@abstract
func length() -> float
