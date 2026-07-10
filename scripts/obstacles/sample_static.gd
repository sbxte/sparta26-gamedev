extends Node2D

@export_range(0.0, 1.0) var spawn_chance: float = 0.5

@export var sprite: Sprite2D
@export var area: Area2D

func _ready() -> void:
	area.monitoring = false

	var spawned := randf() > spawn_chance

	sprite.visible = spawned
	area.monitorable = spawned
