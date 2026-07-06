extends Node

@export var next: TextureButton
@export var back: TextureButton
@export var camera: Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_next_pressed() -> void:
	UiAnimManager.clickAnim(next, Vector2(0.45,0.45), Vector2(0.5,0.5), 0.05)
	back.visible = true
	next.visible = false
	move_cam(camera.position.x + get_viewport().get_visible_rect().size.x, 0.5)

func _on_back_pressed() -> void:
	UiAnimManager.clickAnim(back, Vector2(0.45,0.45), Vector2(0.5,0.5), 0.05)
	back.visible = false
	next.visible = true
	move_cam(camera.position.x - get_viewport().get_visible_rect().size.x, 0.5)

func move_cam(to_x: float, dur: float) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(camera, "position", Vector2(to_x, 0), dur)
