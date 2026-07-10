@abstract
class_name Obstacle
extends Node2D

@export_group("Spawning")
@export_range(0.0, 1.0, 0.01) var base_spawn_chance := 0.5

@abstract
func setup(ses: Session, chance: float) -> void
