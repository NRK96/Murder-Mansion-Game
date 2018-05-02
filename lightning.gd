extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass


func _on_Timer_timeout():
	# Comment out the following line to turn off lightning
	get_node("AnimationPlayer").play("lightningAnim")
	pass
