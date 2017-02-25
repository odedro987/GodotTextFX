extends Control

var messages = []
var currentMessageIndex = 0
var richLabelFX

func _ready():
	richLabelFX = get_node("Panel/Grid/DialogRichLabelFX")
	richLabelFX.updatePosition(Vector2(15, 20))
	set_process_input(true)

func startMessage():
	richLabelFX.updateText(messages[currentMessageIndex])

func setDialogMessages(newMessages):
	self.messages = newMessages

func _input(event):
	if(event.is_action_pressed("next_dialog_message")): 
		if(richLabelFX.done && currentMessageIndex < messages.size() - 1):
			currentMessageIndex = currentMessageIndex + 1
			startMessage()