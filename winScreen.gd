extends Node

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass


func _on_playAgain_pressed():
	get_tree().change_scene("startScreen.tscn")


func _on_quit_pressed():
	get_tree().quit()
