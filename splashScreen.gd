extends Node

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Start_pressed():
	get_tree().change_scene("mainScene.tscn")


func _on_Quit_pressed():
	get_tree().quit()

