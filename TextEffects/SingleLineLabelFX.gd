extends Control

var text = ""
var pos = Vector2(0, 0)
var defaultFont = Label.new().get_font("")
var defaultMonoFont = ""
var byCharRendering = false
var updateDelay = 2
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
var swDelay = 0.003
var swIncrement = 0
var swShift = 0
var swSineInc = 0

func _ready():
	#Initializes the default monospace font.
	defaultMonoFont = get_node("Label").get_font("font")
	#Default text.
	text = ""
	#Enables process function.
	set_process(true)

#Draw function.
func _draw():
	#If not typewriter draw string normally.
	if(!byCharRendering): draw_string(defaultFont, Vector2(pos.x, pos.y), text, Color(r, g, b))
	else:
		#Resets typewriter variables.
		twIncrement = 0
		twSpace = 0
		#Loops through the text upto cutoff.
		while(twIncrement < cutoff):
			#If sine waving is on, increment and calculate the sine wave depending on the char position.
			if(swSineWaveToggle):
				#0.003 is a smoothener || delaying the sine wave effect.
				#Divided by cutoff to save the ratio 0.003.
				swIncrement = swIncrement + (swDelay / cutoff)
				#Adds the increment of the sine to that of the typewriter and multiply by the delay.
				swSineInc = (swIncrement + twIncrement)
				#Sin of the incrementation times 6 times the sine frequency, time the amplitude.
				swShift = (sin(swSineInc  * 6 * swFrequency) * swAmplitude)
			#Draws each letter with consideration to sine wave/shake effects offsets if toggled and the color.
			draw_string(defaultMonoFont, Vector2(pos.x + twSpace*twCharWidth\
						 + (int(rand_range(-sShakeOffset, sShakeOffset)) if sShakeToggle else 0), pos.y\
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

#Sets SingleLineLabelFX.
func setLabel(x, y, text):
	updatePosition(Vector2(x, y))
	updateText(text)
#Updates position.
func updatePosition(newPos):
	self.pos = newPos
	set_pos(pos)
#Updates the text and resets typewriter.
func updateText(text):
	self.text = text
	self.cutoff = 0
	self.timer = 0
#////////////////////////////////////////////RAINBOW/////////////////////////////////////////////////////
#Sets rainbow with all variables.
func setRainbow(incrementStep, frequency, center, width):
	toggleRainbow(true)
	updateRIncrementStep(incrementStep)
	updateRFrequency(frequency)
	updateRCenter(center)
	updateRWidth(width)
#Toggles rainbow option.
func toggleRainbow(pressed):
	self.rRainbowToggle = pressed
	#Resets the rgb values.
	if(!pressed): 
		self.r = 1
		self.g = 1
		self.b = 1
func updateRIncrementStep(value):
	self.rIncrementStep = value
func updateRFrequency(value):
	self.rFrequency = value
func updateRCenter(value):
	self.rCenter = value
func updateRWidth(value):
	self.rWidth = value
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#////////////////////////////////////////////TYPEWRITER//////////////////////////////////////////////////
#Sets typewriter.
func setTypewriter(delay):
	toggleTypewriter(true)
	updateTypewriterDelay(delay)
#Toggles rainbow option.
func toggleTypewriter(pressed):
	self.twTypeWriterToggle = pressed
	self.byCharRendering = pressed
	self.cutoff = 0
	self.timer = 0
func updateTypewriterDelay(value):
	self.twDelay = value
#//////////////////////////////////////////////END///////////////////////////////////////////////////////
#/////////////////////////////////////////////SHAKE//////////////////////////////////////////////////////
#Sets shake.
func setShake(offset):
	toggleShake(true)
	updateShakeOffset(offset)
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
#Sets sine wave.
func setSineWave(frequency, amplitude):
	toggleSineWave(true)
	updateSineFrequency(frequency)
	updateSineAmplitude(amplitude)
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