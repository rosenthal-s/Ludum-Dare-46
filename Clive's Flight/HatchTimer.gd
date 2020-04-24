extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hatching = false





func _on_HatchTimer_timeout():
	if hatching:
		stop()
	else:
		hatching = true
		start()


func _on_start_game_start_timer():
	start()


func _on_visualGameTimer_stopGame():
	stop()
