extends Node2D

@export_range(0.0, 1.0) var spawn_chance: float = 0.5

@export var sprite: Sprite2D
@export var area: Area2D

func _ready() -> void:
	area.monitoring = false

	var spawned := randf() > spawn_chance

	sprite.visible = spawned
	area.monitorable = spawned


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
