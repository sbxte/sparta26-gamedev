extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pivot_offset = self.size / 2.0
	pass # Replace with function body.

func _on_pressed() -> void:
	UiAnimManager.clickAnim(self, Vector2(0.9,0.9), Vector2.ONE, 0.05)
	# set stuff here i guess
