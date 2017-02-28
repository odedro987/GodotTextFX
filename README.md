# GodotTextFX
Text/Label effects for GodotEngine

Welcome to the GodotTextFX wiki!

What's currently included is:
-Text effects such as: shake, sinewave, typewriter, rainbow colors, rotation.
-Dialogs with portraits and callback functions.

The labels and dialogs follow a very specific format:
-For text effects you start with \\#yourtexthere\\x, where # stands for the modifier number(more details in the label class) and the \\x closes the tag.
-For the dialogs callback functions you need to pass a 2D array which includes an array of indexes(which represent the message index) and an array of the function names).

The above are shown in the DialogDemo class.
