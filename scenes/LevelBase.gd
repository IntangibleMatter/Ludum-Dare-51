extends Node2D

var player_seen := false

onready var player := $obj/Player
onready var dialogue_display := $Dialogue
onready var alarm_timer := $AlarmTimer
onready var ui := $UI

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	player.position = $PlayerSpawn.position
	# $Camera2D.position = player.position

	for exit in $Exits.get_children():
		exit.connect("change_level", self, "change_level")
	
	for trigger in $CutsceneTriggers.get_children():
		trigger.connect("start_cutscene", self, "start_cutscene")
	
	for camera in $obj/env/SecurityCameras.get_children():
		camera.connect("player_seen", self, "restart")

func _process(_delta) -> void:
	ui.set_time_left(alarm_timer.time_left)


func change_level(next_level:String) -> void:
	Transition.change_level(next_level)


func start_cutscene(dialogue: PoolStringArray) -> void:
	print("cutscene_start")
	player.pause_movement = true
	dialogue_display.start_dialogue(dialogue)
	alarm_timer.paused = true


func end_cutscene() -> void:
	player.pause_movement = false
	alarm_timer.paused = false

func _on_AlarmTimer_timeout():
	alarm_timer.stop()
	for camera in $obj/env/SecurityCameras.get_children():
		camera.flash()
	yield(get_tree().create_timer(1.1), "timeout")
	alarm_timer.paused = false
	alarm_timer.start(10)

func _on_Dialogue_dialogue_over():
	end_cutscene()

func restart() -> void:
	var death_line : PoolStringArray = ["I've been seen!", "If I could try again, I wonder what I would've done differently...\n\n\n[center][color=#999999]Press Space to restart[/color][/center]"]
	player_seen = true
	start_cutscene(death_line)
	yield(dialogue_display, "dialogue_over")
	Transition.restart()

