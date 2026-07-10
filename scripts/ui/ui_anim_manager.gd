extends Node

func clickAnim(ui, scalebf, scaleaf, dur) -> void:
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)

	tween.tween_property(ui, "scale", scalebf, dur)
	tween.tween_property(ui, "scale", scaleaf, dur)

func moveDownAnim(ui, pos, dur) -> void:
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(ui, "position", pos, dur)
	ui.visible = true
	
func moveUpAnim(ui, pos, dur) -> void:
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)

	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(ui, "position", pos, dur)
	await tween.finished
	ui.visible = false
