extends CanvasLayer

var trans_lines : Array = [
	"ALWAYS\nWATCHING",
	"DON'T\nLET\nTHEM\nCATCH\nYOU",
	"BEHIND\nYOU",
	"THEY\nCAN\nDO\nIT\nAGAIN",
	"YOU\nAREN'T\nSAFE",
	"V0hZIERJRCBZT1UgREVDT0RFIFRISVM/",
	"NO\nONE\nLEFT\nTO\nMISS\nYOU",
	"WHY\nEVEN\nTRY",
	"\n\n\n\n\n\n\n\n\n:)"
]

onready var anim_player := $AnimationPlayer
onready var text_display := $TextureRect/Label

func _ready() -> void:
	randomize()

func change_level(level_path: String) -> void:
	trans_lines.shuffle()
	text_display.text = trans_lines[0]
	get_tree().paused = true
	anim_player.play("start_trans")
	yield(anim_player, "animation_finished")
	#warning-ignore:RETURN_VALUE_DISCARDED
	get_tree().change_scene("res://scenes/" + level_path + ".tscn")
	yield(get_tree().create_timer(0.5), "timeout")
	anim_player.play("end_trans")
	yield(anim_player, "animation_finished")
	get_tree().paused = false
