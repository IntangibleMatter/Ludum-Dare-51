tool
extends Area2D

export(String) var next_level
export(Shape2D) var level_exit_shape

signal change_level(next_level)

func _ready():
	$CollisionShape2D.shape = level_exit_shape

func _process(_delta) -> void:
	if Engine.editor_hint:
		$CollisionShape2D.shape = level_exit_shape
	else:
		set_process(false)
	
func _on_Exit_body_entered(body:Node) -> void:
	if body.is_in_group("Player"):
		emit_signal("change_level", next_level)
