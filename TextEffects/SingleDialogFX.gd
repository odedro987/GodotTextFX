extends Control

var messages = []
var currentMessageIndex = 0
var richLabelFX
var started = false
var callbackNode = null
var callbackData = [[], []]
var currentCallback = 0

func _ready():
	richLabelFX = get_node("Panel/Grid/DialogRichLabelFX")
	richLabelFX.updatePosition(Vector2(5, 20))
	get_node("Panel/Portrait").set_pos(Vector2(45, 45))
	#Enables input.
	set_process_input(true)

#Starts the dialog.
func startMessage():
	if(!started):
		started = true
	if(callbackNode != null):
		if(callbackData[0].size() > 0 && currentCallback < callbackData[0].size()):
			if(currentMessageIndex == callbackData[0][currentCallback]):
				callbackNode.call(callbackData[1][currentCallback])
				currentCallback = currentCallback + 1
	richLabelFX.updateText(messages[currentMessageIndex])

#Sets the dialog variables.
func setDialog(newMessages, delay, newPortrait, callbackNode=null, callbackData=null):
	setDialogMessages(newMessages)
	setPortrait(newPortrait)
	richLabelFX.setTypewriter(delay)
	self.callbackNode = callbackNode
	if(callbackData != null):
		self.callbackData[0] = callbackData[0]
		self.callbackData[1] = callbackData[1]

#Sets the messages.
func setDialogMessages(newMessages):
	self.messages = newMessages

#Sets the portrait.
func setPortrait(newPortrait):
	get_node("Panel/Portrait").set_texture(load(newPortrait))

func _input(event):
	#If the dialog has been started.
	if(started):
		#If next_dialog_message signal is called(SPACE || ENTER).
		if(event.is_action_pressed("next_dialog_message")): 
			#If the current message is done and is not the last.
			if(richLabelFX.done && currentMessageIndex < messages.size() - 1):
				#Increments currentMessageIndex. 
				currentMessageIndex = currentMessageIndex + 1
				#Starts the next message.
				startMessage()