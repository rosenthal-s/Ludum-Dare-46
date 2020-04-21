extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene = load("res://Fruit/FruitScene.tscn")
var numberOfFruits = 0
var fruitPositions = []
var fruitPos = 0
var prevFruits = 0
signal fruitGot


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# Create some fruits on the tree at the beginning at the game
	for i in range(0,3):
		_on_FruitTimer_timeout()

func _process(delta):
	if get_child_count() - 3 < prevFruits:
		emit_signal("fruitGot")
	prevFruits = get_child_count() - 3

func _on_FruitTimer_timeout():
	print("fruit")
	var create = false
	numberOfFruits = get_child_count() - 3
	$FruitSpawnPath/FruitSpawnLocation.set_unit_offset(randf())
	fruitPos = $FruitSpawnPath/FruitSpawnLocation.position
	if numberOfFruits == 0:
		print(fruitPos)
		create = true
	elif numberOfFruits < 3:
		for i in fruitPositions:
			if abs(fruitPos[0] - i[0]) > 20 or abs(fruitPos.y - i[1]) > 20:
				create = true
			else:
				create = false
				break
		
	if create == true:
		fruitPositions = []
		var fruit = scene.instance()
		print(fruit.position)
		print(fruitPos)
		add_child(fruit)
		for i in get_children():
			if i is StaticBody2D:
				fruitPositions.append(i.position)
		fruitPositions.append(fruitPos)
			
		fruit.position = fruitPos



func _on_start_game_start_timer():
	$FruitTimer.start()


func _on_visualGameTimer_stopGame():
	$FruitTimer.stop()
