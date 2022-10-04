extends KinematicBody2D

var acceleration : float = 256
var max_speed : float = 50
var friction := 0.25
var air_resistance := 0.1
var gravity : float = 800
var jump_force : float = 325

var motion := Vector2.ZERO

onready var sprite := $Sprite
onready var anim_player := $AnimationPlayer


func _physics_process(delta: float) -> void:
	if position.x >= 640:
		position.x -= 16

	
	var x_input : float = 1.0

	if x_input != 0:
		sprite.flip_h = x_input < 0
		motion.x += x_input * acceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)

	motion.y += gravity * delta

	if is_on_floor():

		if x_input == 0:
			motion.x = lerp(motion.x, 0, friction)
			anim_player.play("idle")
		else:
			anim_player.play("walk")
		
	
	motion = move_and_slide(motion, Vector2.UP)
