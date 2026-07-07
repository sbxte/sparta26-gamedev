extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await EventManager.session_ready
	# handle ui here
