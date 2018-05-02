extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_playAgain_pressed():
	get_tree().change_scene("startScreen.tscn")


func _on_quit_pressed():
	get_tree().quit()