extends Control

var messages = []
var currentMessageIndex = 0
var richLabelFX

func _ready():
	richLabelFX = get_node("Panel/Grid/DialogRichLabelFX")
	richLabelFX.updatePosition(Vector2(15, 20))
	get_node("Panel/Portrait").set_pos(Vector2(45, 45))
	#Enables input.
	set_process_input(true)

#Starts the dialog.
func startMessage():
	richLabelFX.updateText(messages[currentMessageIndex])

#Sets the dialog variables.
func setDialog(newMessages, delay,  newPortrait):
	setDialogMessages(newMessages)
	setPortrait(newPortrait)
	richLabelFX.setTypewriter(delay)

#Sets the messages.
func setDialogMessages(newMessages):
	self.messages = newMessages

#Sets the portrait.
func setPortrait(newPortrait):
	get_node("Panel/Portrait").set_texture(load(newPortrait))

func _input(event):
	#If next_dialog_message signal is called(SPACE || ENTER).
	if(event.is_action_pressed("next_dialog_message")): 
		#As long as the current message is done and is not the last.
		if(richLabelFX.done && currentMessageIndex < messages.size() - 1):
			#Increments currentMessageIndex. 
			currentMessageIndex = currentMessageIndex + 1
			#Starts the next message.
			startMessage()