extends Area2D

signal player_seen

onready var anim_player := $AnimationPlayer

var can_see_player := false

func _ready():
	pass


func _on_PlayerSensor_body_entered(body:Node) -> void:
	if body.is_in_group("Player"):
		can_see_player = true
	print(can_see_player)


func _on_PlayerSensor_body_exited(body:Node) -> void:
	if body.is_in_group("Player"):
		can_see_player = false
	print(can_see_player)


func check_for_player() -> void:
	print(can_see_player)
	if can_see_player:
		emit_signal("player_seen")


func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "flash":
		anim_player.play("idle")

func flash() -> void:
	print(can_see_player)
	anim_player.play("flash")