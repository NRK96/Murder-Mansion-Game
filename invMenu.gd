extends Panel

# initializes visibility of inventory menu
var visible = false

func _ready():
	set_process(true)
	set_process_input(true)

# opens/closes inventory menu depending on the state of visible
func _process(var delta):
	set_pos(Vector2(get_owner().position.x - 62, get_owner().position.y + 30))

# sets the state of visible by pressing I
func _input(event):
	if(event.is_action_released("Inv") and !global.isPaused):
		if(self.is_visible()):
			self.hide()
		else:
			self.show()
