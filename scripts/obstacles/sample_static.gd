extends Obstacle

@export_range(0.0, 1.0) var spawn_chance: float = 0.5

@export var sprite: Sprite2D
@export var area: Area2D

func _ready() -> void:
	area.monitoring = false
	add_to_group("obstacle")

func setup(_ses: Session, chance: float) -> void:
	var spawned := randf() <= chance

	sprite.visible = spawned
	area.monitorable = spawned
