extends Control

var text = "Hello World!"
var defaultFont = Label.new().get_font("")
var defaultMonoFont = ""
var byCharRendering = false
var updateDelay = 1
var updateCounter = 0
var delayUpdate = false
#Rainbow variables.
var rRainbowToggle = false
var rFrequency = 0.3
var rIncrementStep = 0.3
var rIncrement = 0
var rCenter = 128
var rWidth = 127
var r = 1
var g = 1
var b = 1
#Typewriter variables.
var twTypeWriterToggle = false
var twCharWidth = 11
var twSpace = 0
var twIncrement = 0
var twDelay = 0
var timer = 0
var cutoff = 0
#Shake variables.
var sShakeToggle = false
var sShakeOffset = 1
#Sine Wave variables.
var swSineWaveToggle = false
var swFrequency = 5
var swAmplitude = 10
var swDelay = 1
var swIncrement = 0
var swShift = 0
var swSineInc = 0

func _ready():
	#Initializes the default monospace font.
	defaultMonoFont = get_node("Label").get_font("font")
	#Default text.
	text = "Hello World!"
	#GUI connections.
	get_node("Panel/MainGrid/TextBox").connect("text_changed", self, "updateText")
	get_node("Panel/MainGrid/DelayUpdateButton").connect("toggled", self, "toggleUpdateDelay")
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
	#Enables process function.
	set_process(true)

#Draw function.
func _draw():
	#If not typewriter draw string normally.
	if(!byCharRendering): draw_string(defaultFont, Vector2(100, 100), text, Color(r, g, b))
	else:
		#Resets typewriter variables.
		twIncrement = 0
		twSpace = 0
		#Loops through the text upto cutoff.
		for j in range(cutoff):
			#If sine waving is on, increment and calculate the sine wave depending on the char position.
			if(swSineWaveToggle):
				swIncrement = swIncrement + 1
				#Adds the increment of the sine to that of the typewriter and multiply by the delay.
				swSineInc = swIncrement + twIncrement * swDelay
				#Sin of the incrementation times PI times the sine frequency, time the amplitude.
				swShift = sin(swSineInc * 3.14 * swFrequency) * swAmplitude
			#Draws each letter with consideration to sine wave/shake effects offsets if toggled and the color.
			draw_string(defaultMonoFont, Vector2(100 + twSpace*twCharWidth\
						 + (int(rand_range(-sShakeOffset, sShakeOffset)) if sShakeToggle else 0), 100\
						 + (int(rand_range(-sShakeOffset, sShakeOffset)) if sShakeToggle else 0)\
						 + (int(swShift) if swSineWaveToggle else 0)), text[twIncrement], Color(r, g, b))
			#Incrementing the typewriter.
			twSpace = twSpace + 1
			twIncrement = twIncrement + 1

func _process(delta):
	#If rainbow is on.
	if(rRainbowToggle):
		#Resets the incrementation after 360 
		rIncrement = rIncrement + rIncrementStep if rIncrement <= 360 else 0
		#Sets rgb values to the sin of the frequency times the increment
		#Times the color width plus the center of the color band
		#divided by 255 to convert to float.
		r =  (sin(rFrequency * rIncrement)     * rWidth + rCenter) / 255
		g =  (sin(rFrequency * rIncrement + 2) * rWidth + rCenter) / 255
		b =  (sin(rFrequency * rIncrement + 4) * rWidth + rCenter) / 255
	
	#If typewriter is on.
	if(twTypeWriterToggle):
		#As long as cutoff is less than the string length.
		if(cutoff < text.length()):
			#Resets timer for next iteration.
			if(timer >= twDelay):
				cutoff = cutoff + 1
				timer = 0
			#Increments the timer.
			else: timer = timer + 1
	
	#In case of delaying the update function.
	if(delayUpdate):
		updateCounter = updateCounter + 1 if updateCounter < updateDelay else 0
		if(updateCounter >= updateDelay):
			update()
	else:
		update()

#Returns the rgb value as a Vector3D string.
func getRGBValueString():
	return "(" + str(r) + ", " + str(g) + ", " + str(b) + ")"

#Updates the text and resets typewriter.
func updateText(text):
	self.text = text
	cutoff = 0
	timer = 0

#////////////////////////////////////////////RAINBOW/////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleRainbow(pressed):
	self.rRainbowToggle = pressed
	#Resets the rgb values.
	if(!pressed): 
		r = 1
		g = 1
		b = 1
func updateRIncrementStep(text):
	rIncrementStep = float(text) if text != "" else 0.2
func updateRFrequency(text):
	rFrequency = float(text) if text != "" else 0.4
func updateRCenter(text):
	rCenter = int(text) if text != "" else 128
func updateRWidth(text):
	rWidth = int(text) if text != "" else 127
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#////////////////////////////////////////////TYPEWRITER//////////////////////////////////////////////////
#Toggles rainbow option.
func toggleTypewriter(pressed):
	self.twTypeWriterToggle = pressed
	self.byCharRendering = pressed
	cutoff = 0
	timer = 0
func updateTypewriterDelay(value):
	self.twDelay = value
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#/////////////////////////////////////////////SHAKE//////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleShake(pressed):
	self.sShakeToggle = pressed
func updateShakeOffset(value):
	self.sShakeOffset = value
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#/////////////////////////////////////////////DELAY//////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleUpdateDelay(pressed):
	self.delayUpdate = pressed
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#///////////////////////////////////////////SINE_WAVE////////////////////////////////////////////////////
#Toggles rainbow option.
func toggleSineWave(pressed):
	self.swSineWaveToggle = pressed
func updateSineFrequency(value):
	self.swFrequency = value
func updateSineAmplitude(value):
	self.swAmplitude = value
func updateSineDelay(value):
	self.swDelay = value
#//////////////////////////////////////////////END///////////////////////////////////////////////////////