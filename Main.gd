extends Node

var correct = 0
var presented = 0
var STOP_AT = 100;
var time = 0
var timerPaused = false

func _ready():
	randomize()
	set_process(true)
	next()

func _process(delta):
	if not timerPaused:
		time += delta
		$HUD/Timer.text = str(int(time))
	
func next():
	if (presented >= STOP_AT):
		stop()
	else:
		# Update score
		$HUD/Total.text = str(correct)
		
		# Generate all answers
		$HUD/Up.color = getRandoColour()
		$HUD/Down.color = getRandoColour()
		$HUD/Left.color = getRandoColour()
		$HUD/Right.color = getRandoColour()
		
		# Generate correct answer
		$HUD/Example.color = getRandoColour()
		var correct = randi()%4
		if (correct == 0):
			$HUD/Up.color = $HUD/Example.color
		elif (correct == 1):
			$HUD/Down.color = $HUD/Example.color
		elif (correct == 2):
			$HUD/Left.color = $HUD/Example.color
		elif (correct == 3):
			$HUD/Right.color = $HUD/Example.color

func getRandoColour():
	# Did you know that colours go from 0 to 1 not 255? I didn't!
	return Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1), 1)

func _input(event):
	if (presented >= STOP_AT):
		pass
	elif Input.is_action_just_pressed("ui_up"):
		if $HUD/Up.color == $HUD/Example.color:
			correct += 1
		presented += 1
		next()
	elif Input.is_action_just_pressed("ui_down"):
		if $HUD/Down.color == $HUD/Example.color:
			correct += 1
		presented += 1
		next()
	elif Input.is_action_just_pressed("ui_left"):
		if $HUD/Left.color == $HUD/Example.color:
			correct += 1
		presented += 1
		next()
	elif Input.is_action_just_pressed("ui_right"):
		if $HUD/Right.color == $HUD/Example.color:
			correct += 1
		presented += 1
		next()
		
func stop():
	$HUD/Total.text = str(correct) + "/" + str(presented)
	timerPaused = true