extends CanvasLayer

export(PoolStringArray) var dialogue_array

var current_line := 0
var displaying := false
var in_dialogue := false


var character_time := 0.05

signal dialogue_over

onready var anim_player := $AnimationPlayer
onready var rtl := $Control/Panel/RichTextLabel
onready var dialogue_sound := $AudioStreamPlayer

func start_dialogue(dialogue) -> void:
	in_dialogue = true
	current_line = 0
	dialogue_array = dialogue
	anim_player.play("box_in")
	yield(anim_player, "animation_finished")
	display_dialogue()

func end_dialogue() -> void:
	in_dialogue = false
	rtl.text = ""
	anim_player.play("box_out")
	yield(anim_player, "animation_finished")
	emit_signal("dialogue_over")

func _input(_event: InputEvent) -> void:
	if not in_dialogue:
		return
	if Input.is_action_just_pressed("ui_accept"):
		if displaying:
			rtl.visible_characters = len(rtl.text)
			displaying = false
		else:
			if current_line == dialogue_array.size():
				end_dialogue()
			else:
				display_dialogue()


func display_dialogue() -> void:
	displaying = true
	rtl.visible_characters = 0
	if current_line >= dialogue_array.size():
		return
	rtl.bbcode_text = dialogue_array[current_line]
	for i in range(len(rtl.text)):
		dialogue_sound.play()
		rtl.visible_characters = i
		yield(get_tree().create_timer(character_time), "timeout")
		if rtl.visible_characters == len(rtl.text):
			break
	
	current_line += 1
	displaying = false
