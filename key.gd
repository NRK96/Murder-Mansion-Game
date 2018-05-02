extends TextureButton

var player
var ownPos
var arr = [0, 1, 2, 3, 4, 5]
var inv

func _ready():
	player = get_owner().get_node("player")
	inv = get_node("/root/baseNode/player/invMenu/")
	# Initiallize array
	arr[0] = inv.get_node("itemOne")
	arr[1] = inv.get_node("itemTwo")
	arr[2] = inv.get_node("itemThree")
	arr[3] = inv.get_node("itemFour")
	arr[4] = inv.get_node("itemFive")
	arr[5] = inv.get_node("itemSix")

#collects items
func _on_Key_button_down():
	if(player.position.distance_to(self.get_pos()) < 100 and !global.isPaused):
		global.text = self.get_name()
		get_node("/root/baseNode/player/Panel").updateText()
		hide()
		# Store link to node inside an array in the player script
		player.invArr[player.i] = self
		if(self.get_name() == "Key"):
			player.hasKey = true
		if(self.get_name() == "Knife"):
			player.hasKnife = true
		if(self.get_name() == "Rings"):
			player.hasRings = true
		# Change texture of sprite node in the correct inventory slot
		arr[player.i].get_node("sprite").set_texture(self.get_normal_texture())
		arr[player.i].get_node("sprite").show()
		# Increment number of items
		player.i = player.i + 1