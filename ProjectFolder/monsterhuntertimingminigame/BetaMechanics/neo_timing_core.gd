extends Node2D
#this "NeoCORE" is a mathmatical and much more flexible version of the old code
#I plan on using curves to simplify my code

#imports
@onready var timer: Timer = $Timer
@onready var destination: Sprite2D = $Destination
@onready var timing: Sprite2D = $Timing

#locals
var ReferenceScale: float = 0.0 #meant to make later comparisons easy
var scorescale: Array = ["Miss","Perfect","Good","Okay","Bad"]
var colorarray: Array = [Color.RED,Color.GOLD,Color.GREEN,Color.CADET_BLUE,Color.ORANGE_RED]
var gamedone:bool = false
var cachedscorevalue = null

#exports
#Helper for making the scale non-linear
@export var ScaleCurve: Curve
#Adjusts the initial size of the destination ring and determines the timer.
@export_range(1.0,10.0,0.5) var PrimaryValue: float

func _ready() -> void:
	var scalevalue = ScaleCurve.sample(PrimaryValue)
	destination.scale = cla.numTo_squareVector(1*scalevalue)
	ReferenceScale = destination.scale.x
	_revUP()

func _process(_delta: float) -> void:
	if timer.time_left <= 0.0:
		if gamedone != true:
			cachedscorevalue = scorescale[_strike(timing.scale.x)]
			gamedone = true
		timer.stop()
		cla._handitover(cachedscorevalue)
		self.queue_free()
	else:
		var RemainingTimeRatio = ((timer.time_left)/PrimaryValue)
		var activescale = cla.quickinterpolate(0.8,ReferenceScale + .3,RemainingTimeRatio)
		timing.scale = cla.numTo_squareVector(activescale)
		timing.material.set_shader_parameter("coloradditive",colorarray[_strike(timing.scale.x)])

func _revUP():
	if timer.time_left <= 0.0:
		gamedone = false
		timer.start(PrimaryValue)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			timer.stop()
		elif event.is_pressed() and event.keycode == KEY_ESCAPE:
			_revUP()
		else:
			pass

func _strike(currentpos:float):
	if currentpos >= (ReferenceScale + 0.075): return 0
	elif currentpos >= (ReferenceScale - 0.1): return 1
	elif currentpos >= (ReferenceScale - 0.3): return 2
	elif currentpos >= (ReferenceScale - 0.5): return 3
	else: return 4
