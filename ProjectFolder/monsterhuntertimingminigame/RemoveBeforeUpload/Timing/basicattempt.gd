extends Node2D 
@onready var timer: Timer = $Timer
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var circle_moving: Sprite2D = $"../CircleMoving"
@onready var rating: RichTextLabel = $RATING
@onready var player_stuff: Node2D = $"../PlayerStuff"

var startedonce = false
var gamestart = false
var currprogress: float
var activescale: float = 1.7

@export var seconds: float
@onready var v_slider: VSlider = $"../VSlider"
var cachedscore = "null"

func start_timegame():
	var _state: String
	if timer.time_left <= 0:
		timer.stop()
		_state = "CF" #complete faliure

func rounddecimals(places:int,number:float):
	var rate = pow(10,places)
	number = number * rate
	number = roundf(number)
	number = number/rate
	return number

func movethatmeter(startval, endval, currval):
	return endval + (startval - endval) * currval

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		print("New Attempt Started")
		gamestart = !gamestart
	
	#code to shrink circle
	activescale = .9 + (1.5 - .9) * (.6*rounddecimals(3,(timer.time_left/seconds)))
	circle_moving.scale = Vector2(activescale, activescale)
	#end block
	
	seconds = v_slider.value
	rich_text_label.text = str(seconds)+"/" + str(rounddecimals(3,timer.time_left))
	
	if gamestart:
		timer.start(seconds)
		startedonce = true
		gamestart = !gamestart
	var tl = timer.time_left #abrebiation
	if !gamestart:
		if Input.is_action_just_pressed("ui_accept"): #code to figure out where on the scale you landed
			rating.text = cachedscore
			timer.stop()
	if timer.time_left <= 0.0 and startedonce:
		timer.stop()
		rating.text = timecheck(tl)
		cachedscore = rating.text
		startedonce = !startedonce



func timecheck(tl):
	var output:String
	if  tl >= (seconds/2): 
		output="Bad"
		player_stuff.UPDATE("bad")
		timer.stop()
	elif tl >= (seconds/3) and tl <= (seconds/2): 
		output="Great"
		player_stuff.UPDATE("good")
		timer.stop()
	elif tl >= (seconds/4) and tl <= (seconds/3): 
		output="Good"
		player_stuff.UPDATE("good")
		timer.stop()
	elif tl <= (seconds/4) and tl >= (seconds/8): 
		output="Perfect"
		player_stuff.UPDATE("good")
		timer.stop()
	else: 
		output="Missed"
		player_stuff.UPDATE("bad")
		timer.stop()
	return output
