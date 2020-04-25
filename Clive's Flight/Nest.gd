extends StaticBody2D


var hunger = 60
var hatched = 0
var cawTime = true
signal getScore
signal setHunger(hunger)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _process(delta):
	if hunger > 60:
		hunger = 60
		$HungerTimer.start()
	if hunger <= 0:
		killChick()
		hunger = 60
		$HungerTimer.start()
	emit_signal("setHunger",hunger)

func _on_HungerTimer_timeout():
	hunger -= 1
	
func killChick():  
	var gameover = true
	var chicks = get_children()
	for i in chicks:
		if i.isAlive():
			i.kill()
			gameover = false
			break
	if gameover: print("you lose")
	var waitTime = $HungerTimer.get_wait_time()
	$HungerTimer.set_wait_time(waitTime+0.2)


func _on_dropBox_body_entered(Player):
	emit_signal("getScore")


func _on_Player_setScore(score):
	hunger += score*10


func _on_Egg1_hatched():
	hatched += 1
	var waitTime = $HungerTimer.get_wait_time()
	$HungerTimer.set_wait_time(waitTime-0.3)
	print("egg1 hatched")


func _on_Egg2_hatched():
	hatched += 1
	var waitTime = $HungerTimer.get_wait_time()
	$HungerTimer.set_wait_time(waitTime-0.3)
	print("egg2 hatched")
	
func _on_Egg3_hatched():
	hatched += 1
	var waitTime = $HungerTimer.get_wait_time()
	$HungerTimer.set_wait_time(waitTime-0.3)
	print("egg3 hatched")


func _on_Egg4_hatched():
	hatched += 1
	var waitTime = $HungerTimer.get_wait_time()
	$HungerTimer.set_wait_time(waitTime-0.3)
	print("egg4 hatched")


func _on_dropBox_area_entered(area):
	if area.name == "hitBox":
		hunger -= 10


func _on_cawRegion_area_entered(area):
	if area.name == "hitBox":
		cawTime = false
		$cawRegion/Timer.start()
		var soundNumber = (randi()%5+1)
		for i in $cawRegion/Sounds.get_children():
			soundNumber -= 1
			if soundNumber == 0:
				i.play()


func _on_Timer_timeout():
	cawTime = true
