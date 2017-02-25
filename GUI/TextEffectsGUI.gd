extends Control

var singleLineLabel

func _ready():
	singleLineLabel = get_node("SingleLineLabelFX")
	singleLineLabel.setLabel(200, 200, "Hi")
	get_node("RichLabelFX").setLabel(100, 100, "dsadadsda, adasda, adadasdasdasdasdasdasdasdasdasda, djhasjdghaidajshdasdhada")
	#GUI connections.
	get_node("Panel/MainGrid/TextBox").connect("text_changed", self, "updateText")
	get_node("Panel/MainGrid/DelayUpdateButton").connect("toggled", self, "toggleUpdateDelay")
	get_node("Panel/MainGrid/PositionGrid/PosX").connect("text_changed", self, "updatePosX")
	get_node("Panel/MainGrid/PositionGrid/PosY").connect("text_changed", self, "updatePosY")
	#Rainbow connections.
	get_node("Panel/MainGrid/RainbowGrid/RainbowButton").connect("toggled", self, "toggleRainbow")
	get_node("Panel/MainGrid/RainbowGrid/RIncrement").connect("text_changed", self, "updateRIncrementStep")
	get_node("Panel/MainGrid/RainbowGrid/RFrequency").connect("text_changed", self, "updateRFrequency")
	get_node("Panel/MainGrid/RainbowGrid/RCenter").connect("text_changed", self, "updateRCenter")
	get_node("Panel/MainGrid/RainbowGrid/RWidth").connect("text_changed", self, "updateRWidth")
	#Typewriter connections.
	get_node("Panel/MainGrid/TypewriterGrid/TypewriterButton").connect("toggled", self, "toggleTypewriter")
	get_node("Panel/MainGrid/TypewriterGrid/TWDelay").connect("value_changed", self, "updateTypewriterDelay")
	#Shake connections.
	get_node("Panel/MainGrid/ShakeGrid/ShakeButton").connect("toggled", self, "toggleShake")
	get_node("Panel/MainGrid/ShakeGrid/ShakeOffset").connect("value_changed", self, "updateShakeOffset")
	#Sine wave connections.
	get_node("Panel/MainGrid/SineWaveGrid/SineWaveButton").connect("toggled", self, "toggleSineWave")
	get_node("Panel/MainGrid/SineWaveGrid/SWFrequency").connect("value_changed", self, "updateSineFrequency")
	get_node("Panel/MainGrid/SineWaveGrid/SWAmplitude").connect("value_changed", self, "updateSineAmplitude")
	get_node("Panel/MainGrid/SineWaveGrid/SWDelay").connect("value_changed", self, "updateSineDelay")

#Updates the text and resets typewriter.
func updateText(text):
	singleLineLabel.updateText(text)
func updatePosX(text):
	singleLineLabel.updatePosition(Vector2(float(text) if text != "" else 100, singleLineLabel.pos.y))
func updatePosY(text):
	singleLineLabel.updatePosition(Vector2(singleLineLabel.pos.x, float(text) if text != "" else 100))
#////////////////////////////////////////////RAINBOW/////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleRainbow(pressed):
	singleLineLabel.toggleRainbow(pressed)
func updateRIncrementStep(text):
	singleLineLabel.updateRIncrementStep(float(text) if text != "" else 0.2)
func updateRFrequency(text):
	singleLineLabel.updateRFrequency(float(text) if text != "" else 0.4)
func updateRCenter(text):
	singleLineLabel.updateRCenter(int(text) if text != "" else 128)
func updateRWidth(text):
	singleLineLabel.updateRWidth(int(text) if text != "" else 127)
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#////////////////////////////////////////////TYPEWRITER//////////////////////////////////////////////////
#Toggles rainbow option.
func toggleTypewriter(pressed):
	singleLineLabel.toggleTypewriter(pressed)
func updateTypewriterDelay(value):
	singleLineLabel.updateTypewriterDelay(value)
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#/////////////////////////////////////////////SHAKE//////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleShake(pressed):
	singleLineLabel.toggleShake(pressed)
func updateShakeOffset(value):
	singleLineLabel.updateShakeOffset(value)
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#/////////////////////////////////////////////DELAY//////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleUpdateDelay(pressed):
	singleLineLabel.toggleUpdateDelay(pressed)
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#///////////////////////////////////////////SINE_WAVE////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleSineWave(pressed):
	singleLineLabel.toggleSineWave(pressed)
func updateSineFrequency(value):
	singleLineLabel.updateSineFrequency(value)
func updateSineAmplitude(value):
	singleLineLabel.updateSineAmplitude(value)
func updateSineDelay(value):
	singleLineLabel.updateSineDelay(value)
#//////////////////////////////////////////////END///////////////////////////////////////////////////////