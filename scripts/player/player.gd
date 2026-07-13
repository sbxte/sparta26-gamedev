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

func _ready() -> void:
	var hitbox = Area2D.new()
	hitbox.name = "PlayerHitBox"
	add_child(hitbox)
	var hitbox_shape = CollisionShape2D.new()
	var box = RectangleShape2D.new()
	box.size = Vector2(40, 60) 
	hitbox_shape.shape = box
	
	hitbox.add_child(hitbox_shape)
	hitbox.area_entered.connect(_on_obstacle_entered)
	
	# hitbox that will be disabled during slide
	var hitbox2 = Area2D.new()
	hitbox2.name = "PlayerHitBox2"
	add_child(hitbox2)
	var hitbox2_shape = CollisionShape2D.new()
	hitbox2.position.y = -64
	hitbox2_shape.shape = box
	
	hitbox.add_child(hitbox_shape)
	hitbox.area_entered.connect(_on_obstacle_entered)
	hitbox2.add_child(hitbox2_shape)
	hitbox2.area_entered.connect(_on_obstacle_entered)
func hit():
	health = health-1
	EventManager.emit_signal("player_hit", health)
	
	
func _on_obstacle_entered(incoming_area: Area2D) -> void:
	# Memeriksa apakah area yang masuk atau induk rintangannya memiliki grup "obstacle"
	if incoming_area.is_in_group("obstacle") or incoming_area.get_parent().is_in_group("obstacle"):
		hit()
