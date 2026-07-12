extends Obstacle

@export var final_delta := Vector2.ZERO
@export var appear_dist := 200

@export var moving_node: Node2D
@export var sprite: AnimatedSprite2D
@export var area: Area2D

var session: Session

func _ready() -> void:
	area.monitoring = false
	add_to_group("obstacle")
	area.add_to_group("obstacle")

func _physics_process(_delta: float) -> void:
	if seghandler_dist() < appear_dist:
		moving_node.transform.origin = activation_ratio() * final_delta

func _process(_delta: float) -> void:
	sprite.z_index = 0 + 4 * ((seghandler_dist() > appear_dist) as int)

func setup(ses: Session, chance: float) -> void:
	session = ses
	var spawned := randf() <= chance

	sprite.visible = spawned
	area.monitorable = spawned

func seghandler_dist() -> float:
	return (self.global_position - session.segment_handler.global_position).x

func activation_ratio() -> float:
	return (appear_dist - seghandler_dist()) / appear_dist
