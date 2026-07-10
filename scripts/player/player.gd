class_name Player
extends CharacterBody2D
signal player_died

@export_group("Movement")
@export var gravity := 2000.0
@export var jump_vel := 1000.0
var health := 3
# This does not look elegant at all
@export_group("States")
@export var sprite_run: AnimatedSprite2D
@export var collision_run: CollisionShape2D
@export var sprite_jump: AnimatedSprite2D
@export var collision_jump: CollisionShape2D
@export var sprite_slide: AnimatedSprite2D
@export var collision_slide: CollisionShape2D

var state := Constants.PlayerState.RUNNING
var _anim_state := -1   # last state we started an animation for; -1 forces the first play

func _physics_process(_delta: float) -> void:
	if self.is_on_floor() and Input.is_action_pressed("ui_up"):
		self.velocity.y = -jump_vel
		state = Constants.PlayerState.JUMPING
	elif self.is_on_floor() and Input.is_action_pressed("ui_down"):
		state = Constants.PlayerState.SLIDING
	elif self.is_on_floor():
		state = Constants.PlayerState.RUNNING
	# TODO: Implement sliding... how does that affect the player when they're in the jumping state actually??
	self.velocity.y += gravity * _delta
	self.move_and_slide()
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("obstacle"):
			hit()

	collision_run.disabled = state != Constants.PlayerState.RUNNING
	collision_jump.disabled = state != Constants.PlayerState.JUMPING
	collision_slide.disabled = state != Constants.PlayerState.SLIDING


func _process(_delta: float) -> void:
	sprite_run.visible = state == Constants.PlayerState.RUNNING
	sprite_jump.visible = state == Constants.PlayerState.JUMPING
	sprite_slide.visible = state == Constants.PlayerState.SLIDING

	# Start the matching animation only when the state changes, so playback isn't
	# restarted to frame 0 every frame.
	if state != _anim_state:
		_anim_state = state
		match state:
			Constants.PlayerState.RUNNING: sprite_run.play()
			Constants.PlayerState.JUMPING: sprite_jump.play()
			Constants.PlayerState.SLIDING: sprite_slide.play()


func hit():
	health = health-1
	EventManager.emit_signal("player_hit", health)
	# On death the Session ends the run (forced loss) and handles the results
	# scene transition — see Session._on_player_hit.
	
