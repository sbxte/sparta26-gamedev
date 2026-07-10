class_name Player
extends CharacterBody2D
signal player_died
enum PlayerState { RUNNING, JUMPING, SLIDING }

@export_group("Movement")
@export var gravity := 2000.0
@export var jump_vel := 1000.0
var health := 3
# This does not look elegant at all
@export_group("States")
@export var sprite_run: Sprite2D
@export var collision_run: CollisionShape2D
@export var sprite_jump: Sprite2D
@export var collision_jump: CollisionShape2D
@export var sprite_slide: Sprite2D
@export var collision_slide: CollisionShape2D

var state := PlayerState.RUNNING

func _physics_process(_delta: float) -> void:
	if self.is_on_floor() and Input.is_action_pressed("ui_up"):
		self.velocity.y = -jump_vel
		state = PlayerState.JUMPING
	elif self.is_on_floor() and Input.is_action_pressed("ui_down"):
		state = PlayerState.SLIDING
	elif self.is_on_floor():
		state = PlayerState.RUNNING
	# TODO: Implement sliding... how does that affect the player when they're in the jumping state actually??
	self.velocity.y += gravity * _delta
	self.move_and_slide()
	var collision = get_last_slide_collision()
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("obstacle"):
			hit()

	collision_run.disabled = state != PlayerState.RUNNING
	collision_jump.disabled = state != PlayerState.JUMPING
	collision_slide.disabled = state != PlayerState.SLIDING


func _process(_delta: float) -> void:
	sprite_run.visible = state == PlayerState.RUNNING
	sprite_jump.visible = state == PlayerState.JUMPING
	sprite_slide.visible = state == PlayerState.SLIDING


func hit():
	health = health-1
	if health == 0:
		get_tree().change_scene_to_file("res://scenes/ui/results.tscn")
	
