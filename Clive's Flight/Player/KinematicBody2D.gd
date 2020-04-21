extends KinematicBody2D


#variables & constants initiated
var velocity = Vector2.ZERO
var pathVector = Vector2.ZERO
var buttonPress = false
const MAX_SPEED = 37
const MIN_SPEED = 250
const ACCELERATION = 30 * 60
const FRICTION = 50 * 60
const GRAVITY = 12
const DEADZONE = 15
const SLOWZONE = 80
var score = 0
signal setScore(score)


func _ready():
	$PlayerSprite.play("E")


func _process(delta):
	#print("Player Score: ",score)
	#calculate the angle between the mouse and the player
	if buttonPress == true:
		var angle = 0
		if pathVector.x == 0:
			angle = 90
		else:
			angle = abs(rad2deg(atan(pathVector.y/pathVector.x)))
			
		#uses the previously calculated angle, and the sign of the pathVector to determine which direction
		#the sprite should be facing and animates it accordingly
		if pathVector.x >= 0 and pathVector.y >= 0:
			if angle < 22.5: $PlayerSprite.play("E")
			elif angle > 67.5: $PlayerSprite.play("S")
			else: $PlayerSprite.play("SE")
		elif pathVector.x <= 0 and pathVector.y >= 0:
			if angle > 67.5: $PlayerSprite.play("S")
			elif angle < 22.5: $PlayerSprite.play("W")
			else: $PlayerSprite.play("SW")
		elif pathVector.x <= 0 and pathVector.y <= 0:
			if angle < 22.5: $PlayerSprite.play("W")
			elif angle > 67.5: $PlayerSprite.play("N")
			else: $PlayerSprite.play("NW")
		else:
			if angle > 67.5: $PlayerSprite.play("N")
			elif angle < 22.5: $PlayerSprite.play("E")
			else: $PlayerSprite.play("NE")
	
	

func _physics_process(delta):
	#declare variables for the player coordinates, mouse coordinates,
	if buttonPress == true: 
		var mousePos = Vector2()
		var playerPos = Vector2()
		var vectorLength = 0
		#get the player and mouse coordinates as a vector
		mousePos = get_global_mouse_position()
		playerPos = get_position()
		#find the difference between the two vectors
		pathVector.x = mousePos.x - playerPos.x
		pathVector.y = mousePos.y - playerPos.y
		vectorLength = pathVector.length()
		pathVector = pathVector.normalized()
		#detects if the player is pressing the "accept" button
		#(will trigger for enter, space, or left click)
		if Input.is_action_just_pressed("ui_accept"):
			print("BOOM")
		
		#if the mouse is not inside the slowzone the player accelerates towards the max speed
		#at a rate proportional to the square root of the distance from the mouse (vectorLength)
		if vectorLength >= SLOWZONE:
			velocity = velocity.move_toward(pathVector * MAX_SPEED * sqrt(vectorLength), ACCELERATION * delta)
		#if the mouse is inside the slowzone but not in the deadzone the player accelerates towards
		#the min speed at a constant rate
		elif vectorLength >= DEADZONE:
			velocity = velocity.move_toward(pathVector * MIN_SPEED, ACCELERATION * delta)
		#if the mouse is inside the deadzone, the player does not accelerate at all
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity)
		


func _on_Tree_fruitGot():
	score += 1


func _on_Nest_getScore():
	emit_signal("setScore",score)
	score = 0


func _on_Nest_setHunger(hunger):
	hunger = str(hunger)
	$hungerBar.play(hunger)


func _on_pointerRegion_body_entered(Nest):
	$pointer/pointerSprite.play("blank")


func _on_pointerRegion_body_exited(Nest):
	$pointer/pointerSprite.play("pointing")


func _on_start_game_start_timer():
	buttonPress = true


func _on_visualGameTimer_stopGame():
	buttonPress = false
