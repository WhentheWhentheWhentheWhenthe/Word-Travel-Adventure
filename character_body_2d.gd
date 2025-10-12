extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0

@onready var rover_move_sound: AudioStreamPlayer2D = $RoverMoveSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var sprite: Sprite2D = $Sprite2D  # Reference to the player sprite

var fade_out := false

func _physics_process(delta):
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

	# Flip sprite based on movement direction
	if direction != 0:
		sprite.flip_h = direction < 0

	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = jump_velocity
			# Ensure jump sound always plays at normal volume, and never overlaps
			jump_sound.stop()
			jump_sound.volume_db = 0.0
			jump_sound.play()

	_handle_rover_move_sound(direction)
	move_and_slide()

func _handle_rover_move_sound(direction):
	var should_move = abs(direction) > 0.1 and is_on_floor()
	if should_move:
		if fade_out:
			# If we were fading out, immediately restore volume and cancel fade
			rover_move_sound.volume_db = 0.0
			fade_out = false
		if rover_move_sound.stream_paused:
			rover_move_sound.stream_paused = false
			rover_move_sound.volume_db = 0.0
		elif not rover_move_sound.playing:
			rover_move_sound.volume_db = 0.0
			rover_move_sound.seek(0.0)
			rover_move_sound.play()
	else:
		if rover_move_sound.playing and not fade_out:
			fade_out = true

	# Fade out only if we're supposed to
	if fade_out and rover_move_sound.playing:
		rover_move_sound.volume_db = lerp(rover_move_sound.volume_db, -80.0, 0.15)
		if rover_move_sound.volume_db < -60.0:
			rover_move_sound.stream_paused = true
			rover_move_sound.volume_db = 0.0  # Reset for next play
			fade_out = false


func _on_game_over_trigger_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	pass # Replace with function body.
