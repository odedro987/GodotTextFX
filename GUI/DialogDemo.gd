extends Control

func _ready():
	get_node("SingleDialogFX").setDialogMessages(["Engel: ich bin \\7schön\\x, \\2Oder~?\\x"])
	get_node("SingleDialogFX").startMessage()