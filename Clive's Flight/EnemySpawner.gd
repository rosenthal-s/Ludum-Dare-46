extends StaticBody2D


var scene = load("res://Enemy.tscn")
var nameCount = 0
var wave = 0
var waveMax = randi()%4+3

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _on_SpawnTimer_timeout():
	$EnemySpawnPath/EnemySpawnLocation.set_unit_offset(randf())
	var enemy = scene.instance()
	enemy.name = "Enemy_"+str(nameCount)
	nameCount += 1
	add_child(enemy)
	enemy.position = $EnemySpawnPath/EnemySpawnLocation.position
	if wave < waveMax:
		print("wave:", wave)
		$SpawnTimer.start()
		wave += 1
	else:
		$LongSpawnTimer.start()
		print("wavemax:", waveMax)
		wave = 0
		waveMax = randi()%4+3


func _on_start_game_start_timer():
	$SpawnTimer.start()


func _on_visualGameTimer_stopGame():
	$SpawnTimer.stop()
	
	


func _on_visualTimer_stopGame():
	var enemy = get_children()
	for i in enemy:
		if i.isAlive(): i.queue_free()



func _on_Player_squawked(playerPos):
	var enemies = get_children()
	for enemy in enemies:
		print("enemy:", enemy)
		if enemy.isAlive():
			if sqrt(pow(enemy.get_enemyPos().x - playerPos.x, 2) + pow(enemy.get_enemyPos().y - playerPos.y, 2)) <= 150:
				print("BOOM")
				enemy.scared()


func _on_LongSpawnTimer_timeout():
	_on_SpawnTimer_timeout()
