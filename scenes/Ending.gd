extends Node2D


func _ready():
	if not AudioServer.is_bus_mute(1):
		AudioServer.set_bus_volume_db(1, -999)
