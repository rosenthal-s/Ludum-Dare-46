extends Timer




func _on_detection_area_body_entered(Player):
	if Player.getScore() < 4:
		start()


func _on_detection_area_body_exited(Player):
	stop()
