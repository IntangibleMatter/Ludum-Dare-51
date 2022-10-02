extends Control

func _on_Button_pressed():
	Transition.change_level("00")


func _on_CheckButton_toggled(button_pressed:bool):
	AudioServer.set_bus_mute(1, !button_pressed)
