extends CanvasLayer

onready var progress := $TextureProgress

func set_time_left(time: float) -> void:
	progress.value = 10 - time