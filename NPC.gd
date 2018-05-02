extends KinematicBody2D

var speed = 150
var player
var textarr = [0, 1, 2, 3, 4, 5]
var arr = [0, 1, 2, 3, 4, 5]
var inv
var textBox
var textPanel
var isSpeaking
var knife
var talkButton
var attackButton
var silverKey
var key
var sprite

func _ready():
	# Initialize everything
	# Dialogue 
	textarr[0] = "I think someone's hiding in the\nstorage room."
	textarr[1] = "I thought I saw someone suspicious\ncome from that bedroom by where\none of the guests were killed."
	textarr[2] = "..."
	textarr[3] = "I lost my wedding rings in the confusion.\nIt's all I have to remember her by.\nI've got to find them!"
	textarr[4] = "You found them! Thanks, while\nsearching I found this key.\nI don't know what it goes to,\nbut here take it,\nit's the least I can do."
	textarr[5] = "The eagle eyed explorer can find\nsome good loot, I swear I\nsaw something shiny around here,\nif only I can find it again."
	# Shortcuts
	silverKey = get_tree().get_root().get_node("baseNode/Items/SilverKey")
	inv = get_node("/root/baseNode/player/invMenu/")
	player = get_owner().get_node("player")
	textBox = get_node("talkButton/text")
	textPanel = get_node("talkButton/textPanel")
	talkButton = get_node("talkButton")
	attackButton = get_node("talkButton/attackButton")
	sprite = get_node("Sprite")
	# Inventory slots
	arr[0] = inv.get_node("itemOne")
	arr[1] = inv.get_node("itemTwo")
	arr[2] = inv.get_node("itemThree")
	arr[3] = inv.get_node("itemFour")
	arr[4] = inv.get_node("itemFive")
	arr[5] = inv.get_node("itemSix")
	set_fixed_process(true)

func _fixed_process(delta):
	# If not paused and distance is greater than 130, update position along path
	if(!global.isPaused and !checkDistance()):
		get_parent().set_offset(get_parent().get_offset() + (speed*delta))
		sprite.set_rotd(-90)
		talkButton.hide()
		isSpeaking = false
	
	# This should only run once each time the npc stops, and resets when it resumes
	elif(!global.isPaused and !isSpeaking):
		textBox.set_text("Hello!")
		sprite.set_global_rot(sprite.get_global_pos().angle_to_point(player.globalPos))
		# Rotates the text pieces so that they appear correctly regardless of npc rotation
		talkButton.set_rotation_deg(-get_parent().get_global_rotd())
		talkButton.show()
		isSpeaking = true
	
	# Rotate NPC sprite to face player when speaking
	elif(isSpeaking):
		sprite.set_global_rot(sprite.get_global_pos().angle_to_point(player.globalPos))
	
	
	# Update panel size to match text
	textPanel.set_size(textBox.get_size())
	textPanel.set_pos(textBox.get_pos())

func checkDistance():
	# Return true if closer than 130, false if not
	if(player.position.distance_to(self.get_global_pos()) < 130):
		return true
	return false

func _on_talkButton_pressed():
	if(checkDistance()):
		updateText()
		
func _on_attackButton_pressed():
	if(player.hasKnife):
		if(self.get_name() == "NPC 3"):
			get_node("/root/baseNode/Items/Key").set_pos(get_parent().get_global_pos())
			get_node("/root/baseNode/Items/Key").show()
			get_parent().queue_free()
		else:
			get_tree().change_scene("gameOverOne.tscn")
	else:
		global.text = "You need a weapon first."
		get_node("/root/baseNode/player/Panel").updateText()
	#else:
	#	textbox.set_text("You need a weapon first.")

# This function will update the text according to some conditions
func updateText():
	var name = self.get_name()
	var i
	# Assign text based on NPC name
	if(name == "NPC 1"):
		i = 0
	if(name == "NPC 2"):
		i = 1
		get_node("/root/baseNode/Items/Knife").show()
	if(name == "NPC 3"):
		i = 2
	if(name == "NPC 4"):
		# npc looking for his rings
		if(player.hasRings == false):
			i = 3
			get_node("/root/baseNode/Items/Rings").show()
		# Player gives npc rings in exchange for the door key
		else:
			i = 4
			# Get rid of rings
			player.i = player.i - 1
			global.text = "Silver Key"
			get_node("/root/baseNode/player/Panel").updateText()
			player.hasSilverKey = true
			# acquire key
			arr[player.i].get_node("sprite").set_texture(silverKey.get_normal_texture())
			arr[player.i].get_node("sprite").show()
			player.i = player.i + 1
	if(name == "NPC 5"):
		i = 5
	textBox.set_text(textarr[i])
	textPanel.set_size(textBox.get_size())
	textPanel.set_pos(textBox.get_pos())
