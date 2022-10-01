extends KinematicBody2D

var acceleration : float = 512
var max_speed : float = 256
var friction := 0.25
var air_resistance := 0.1
var gravity : float = 800
var jump_force : float = 325

var motion := Vector2.ZERO

export(NodePath) var camera

onready var sprite := $Sprite
onready var anim_player := $AnimationPlayer

# timers so the game feels nicer to play.
onready var early_jump_timer := $Timers/EarlyJumpPressTimer # timer so that if you press jump early you still jump
onready var coyote_timer := $Timers/CoyoteTimer # 

func _ready() -> void:
	$RemoteTransform2D.remote_path = camera

func _physics_process(delta: float) -> void:
	var x_input : float = Input.get_action_strength("ui_right") - Input.get_action_raw_strength("ui_left")

	if x_input != 0:
		sprite.flip_h = x_input < 0
		motion.x += x_input * acceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)

	motion.y += gravity * delta

	if is_on_floor():
		coyote_timer.start(0.1)

		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
			anim_player.play("idle")
		else:
			anim_player.play("walk")

		if Input.is_action_just_pressed("ui_jump") or early_jump_timer.time_left > 0:
			motion.y = -jump_force
		
	else:
		anim_player.play("jump")
		if Input.is_action_just_pressed("ui_jump"):
			if coyote_timer.time_left > 0:
				motion.y = -jump_force
				coyote_timer.start(0)
			else:
				early_jump_timer.start(0.1)

		if Input.is_action_just_released("ui_jump") and motion.y < -jump_force / 2:
			motion.y = -jump_force / 2

		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_resistance)
	
	motion = move_and_slide(motion, Vector2.UP)
