extends Node

var lastscore = null
var controller_node = null

func quickinterpolate(startval, endval, currval):
	return endval + (startval - endval) * currval

func _handitover(value):
	lastscore = value
	if controller_node != null:
		controller_node._on_recieve(lastscore)

func rounddecimals(places:int,number:float):
	var rate = pow(10,places)
	number = number * rate
	number = roundf(number)
	number = number/rate
	return number

func numTo_squareVector(value:float):
	return Vector2(value,value)
