extends Obstacle

@export var speed := 50.0
@export var right := false

@export var sprite: AnimatedSprite2D
@export var area: Area2D

func _ready() -> void:
	area.monitoring = false
	add_to_group("obstacle")

func _physics_process(delta: float) -> void:
	self.transform.origin.x += speed * delta * ((right as int) * 2 - 1)

func setup(_ses: Session, chance: float) -> void:
	var spawned := randf() <= chance

	sprite.visible = spawned
	area.monitorable = spawned
