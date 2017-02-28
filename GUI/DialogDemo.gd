extends Control

func _ready():
	get_node("SingleDialogFX").setDialogMessages(["Angel: I'm \\2pretty\\x, \\3aren't I~?\\x", "\\3YES!\\X I \\4AM!\\X", "\\7I'm FABULOUS~!\\x"])
	get_node("SingleDialogFX").startMessage()
	get_node("MultiDialogFX").setDialog(["1Derpmon: \\1Err h-hey.\\x",\
										 "0Derpgel: \\2uhm...\\x yes?",\
										 "1Derpmon: Uhm.. \\1wou-\\x",\
										 "0Derpgel: \\9I've\\x got a \\4boyfriend.\\x",\
										 "1Derpmon: Well, \\7me too!\\x",\
										 "0Derpgel: Huh?",\
										 "1Derpmon: \\2Oh...\\x"],\
										 ["res://Assets/Derpgel.png", "res://Assets/Derpotaur.png"], 0.9, self, [[0, 2, 5], ["a", "b", "c"]])
	get_node("MultiDialogFX").startMessage()

func a():
	print("a")
func b():
	print("b")
func c():
	print("c")