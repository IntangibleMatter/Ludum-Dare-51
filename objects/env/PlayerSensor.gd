extends Area2D

signal player_seen

onready var anim_player := $AnimationPlayer

var can_see_player := false

func _ready():
	pass


func _on_PlayerSensor_body_entered(body:Node) -> void:
	can_see_player = body.is_in_group("Player")


func _on_PlayerSensor_body_exited(body:Node) -> void:
	can_see_player = body.is_in_group("Player")


func check_for_player() -> void:
	pass


func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "flash":
		anim_player.play("idle")

func flash() -> void:
	pass