extends Node2D

onready var player := $obj/Player

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	player.position = $PlayerSpawn.position

	for exit in $Exits.get_children():
		exit.connect("change_level", self, "change_level")

func change_level(next_level:String) -> void:
	Transition.change_level(next_level)
