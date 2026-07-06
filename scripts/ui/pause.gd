extends Node

@export var button_array: Array[TextureButton]
# resume = 0, settings = 1, levelselect = 2
@export var settings: Node

var paused: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	paused = true
	for i in range(len(button_array)):
		button_array[i].pressed.connect(_on_button_pressed.bind(i))

func _on_button_pressed(idx: int) -> void:
	UiAnimManager.clickAnim(button_array[idx], Vector2(0.9,0.9), Vector2.ONE, 0.05)
	match idx:
		0: paused = false; handle_pause()
		1: UiAnimManager.moveDownAnim(settings, Vector2.ZERO, 0.3)
		2: get_tree().change_scene_to_file("")

func handle_pause() -> void:
	get_tree().paused = paused
	if paused:
		UiAnimManager.moveDownAnim(self, Vector2.ZERO, 0.3)
	else:
		UiAnimManager.moveUpAnim(self, Vector2(0, -1080), 0.3)
	await get_tree().create_timer(0.5).timeout # debounce asddsdd
