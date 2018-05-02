extends StaticBody2D

var openOrClosed = false
var reopen = false
var player

func _ready():
	player = get_owner().get_node("player")


func _on_doorButton_pressed():
	global.text = self.get_name()
	get_node("/root/baseNode/player/Panel").updateText()
	# door4 is locked
	if(self.get_name() != "door4"):
		if(openOrClosed == false and checkDistance()):
			set_rotd(get_rotd() + 90)
			openOrClosed = true
		elif(openOrClosed == true and checkDistance()):
			set_rotd(get_rotd() - 90)
			openOrClosed = false
	# if player has the key, door4 can be opened
	elif(player.hasSilverKey == true):
		if(openOrClosed == false and checkDistance()):
			set_rotd(get_rotd() + 90)
			openOrClosed = true
		elif(openOrClosed == true and checkDistance()):
			set_rotd(get_rotd() - 90)
			openOrClosed = false
func checkDistance():
	if(player.position.distance_to(self.get_global_pos()) < 130):
		return true
	return false