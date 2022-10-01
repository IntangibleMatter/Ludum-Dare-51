extends CanvasLayer

var player_moved := false

func _ready() -> void:
	yield(get_tree().create_timer(5), "timeout")
	if not player_moved:
		var tween : SceneTreeTween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property($Label, "modulate", Color.white, 1)


func _on_PlayerMovementDetector_body_entered(body:Node) -> void:
	if body.is_in_group("Player"):
		player_moved = true

		var tween : SceneTreeTween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.tween_property($Label, "modulate", Color("#00ffffff"), 1)
		tween.tween_callback(self, "queue_free")
