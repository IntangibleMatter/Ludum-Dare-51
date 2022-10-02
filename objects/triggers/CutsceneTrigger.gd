tool
extends Area2D

export(PoolStringArray) var dialogue
export(Shape2D) var cutscene_trigger_shape

signal start_cutscene(dialogue)

func _ready():
	$CollisionShape2D.shape = cutscene_trigger_shape
	for i in range(dialogue.size()):
		dialogue[i] = dialogue[i].replace("~", "\n") + " "


func _process(_delta) -> void:
	if Engine.editor_hint:
		$CollisionShape2D.shape = cutscene_trigger_shape
	else:
		set_process(false)

func _on_CutsceneTrigger_body_entered(body:Node):
	if body.is_in_group("Player"):
		emit_signal("start_cutscene", dialogue)
		set_deferred("monitoring", false)