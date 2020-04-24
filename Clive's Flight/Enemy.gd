extends KinematicBody2D


var velocity = Vector2.ZERO
var pathVector = Vector2.ZERO
var nestPos = Vector2(2952, 1615.040039)
var enemyPos = Vector2()
var flyAwayVector = Vector2()
const MAX_SPEED = 100
const MIN_SPEED = 250
const ACCELERATION = 100 * 60
const FRICTION = 50 * 60
const GRAVITY = 12
const WIGGLE_RANGE = Vector2(50,80)
var fleeing = false


func _process(delta):
	var angle = 0
	if pathVector.x == 0:
		angle = 90
	else:
		angle = abs(rad2deg(atan(pathVector.y/pathVector.x)))
		
	#uses the previously calculated angle, and the sign of the pathVector to determine which direction
	#the sprite should be facing and animates it accordingly
	if pathVector.x >= 0 and pathVector.y >= 0:
		if angle < 22.5: $crowSprite.play("E")
		elif angle > 67.5: $crowSprite.play("S")
		else: $crowSprite.play("SE")
	elif pathVector.x <= 0 and pathVector.y >= 0:
		if angle > 67.5: $crowSprite.play("S")
		elif angle < 22.5: $crowSprite.play("W")
		else: $crowSprite.play("SW")
	elif pathVector.x <= 0 and pathVector.y <= 0:
		if angle < 22.5: $crowSprite.play("W")
		elif angle > 67.5: $crowSprite.play("N")
		else: $crowSprite.play("NW")
	else:
		if angle > 67.5: $crowSprite.play("N")
		elif angle < 22.5: $crowSprite.play("E")
		else: $crowSprite.play("NE")


func _physics_process(delta):
	#declare variables for the player coordinates, mouse coordinates, 
	var vectorLength = 0
	#get the player and mouse coordinates as a vector
	enemyPos = get_position()
	#find the difference between the two vectors
	pathVector.x = nestPos.x - enemyPos.x
	pathVector.y = nestPos.y - enemyPos.y
	pathVector = pathVector.normalized()

	velocity = velocity.move_toward(pathVector * MAX_SPEED, ACCELERATION * delta)

	velocity.y += GRAVITY
	velocity = move_and_slide(velocity)


func _on_WiggleTimer_timeout():
	velocity += Vector2(randf()*WIGGLE_RANGE.y+WIGGLE_RANGE.x,randf()*WIGGLE_RANGE.y+WIGGLE_RANGE.x)


func _on_hitBox_area_entered(area):
	if area.name == "dropBox":
		randomize()
		$flyAwayPath/flyAwayLocation.set_unit_offset(randf())
		nestPos = $flyAwayPath/flyAwayLocation.position
		

func get_enemyPos():
	return enemyPos


func isAlive():
	return true


func scared():
	randomize()
	if fleeing == false:
		$flyAwayPath/flyAwayLocation.set_unit_offset(randf())
		nestPos = $flyAwayPath/flyAwayLocation.position
		fleeing = true
