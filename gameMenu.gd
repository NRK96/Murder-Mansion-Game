extends Panel

onready var playerPos = get_parent().get_node("player").get_pos()
var ownSize = self.get_size()
onready var controlPanel = get_parent().get_node("controlsPanel")
onready var controlSize = controlPanel.get_size()

func _ready():
	set_process(true)
	set_process_input(true)
func _process(var delta):
	
	pass

func _input(event):
	if(event.is_action_released("openMenu")):
		
		if(!self.is_visible()):
			global.isPaused = true
			self.show()
		else:
			global.isPaused = false
			controlPanel.hide()
			self.hide()
		
		# Update stored player position and then update own position
		playerPos = get_parent().get_node("player").get_pos()
		ownSize = self.get_size()
		self.set_pos(Vector2(playerPos.x - ownSize.x/2, playerPos.y - ownSize.y/2))
		# Close inventory if open
		get_owner().get_node("invMenu").hide()

func _on_resumeButton_pressed():
	self.hide()
	global.isPaused = false


func _on_exitButton_pressed():
	get_tree().quit()

func _on_close_pressed():
	controlPanel.hide()


func _on_controlsButton_pressed():
	controlPanel.show()
	# Center control panel's position based on player's position
	controlPanel.set_pos(Vector2(playerPos.x - controlSize.x/2, playerPos.y - controlSize.y/2))


func _on_closeControlsButton_pressed():
	controlPanel.hide()
