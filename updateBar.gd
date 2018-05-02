extends Panel

var string = ""
var i = 0
onready var lab = get_node("Label")
onready var player = get_owner()
var locked = true
var scale = Vector2(1,1)

func _ready():
	set_process(true)
	updateText()

func _process(var delta):
	scale.x = self.get_size().x/160
	scale.y = self.get_size().y/75
	set_pos(Vector2(get_owner().position.x - (400*scale.x),
			get_owner().position.y - (260*scale.y)))

func updateText():
	if(i == 4):
		string = ""
		i = 0
	if(global.text == "door4"):
		i = i+1
		if(player.hasSilverKey == false):
			string = string + "It's locked...\n"
			lab.set_text(string)
		elif(locked == true):
			locked = false
			string = string + "Door unlocked!\n"
			lab.set_text(string)
	elif(global.text == "You need a weapon first."):
		i = i+1
		string = string + global.text + "\n"
		lab.set_text(string)
	elif(global.text == "Key"):
		i = i+1
		string = string + "Key collected!\n"
		lab.set_text(string)
	elif(global.text == "Knife"):
		i = i+1
		string = string + "Knife collected!\n"
		lab.set_text(string)
	elif(global.text == "Rings"):
		i = i+1
		string = string + "Rings collected!\n"
		lab.set_text(string)
	elif(global.text == "Silver Key"):
		i = i+1
		string = string + "Silver key collected!\n"
		lab.set_text(string)