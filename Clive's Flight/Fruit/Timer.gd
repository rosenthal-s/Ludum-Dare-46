extends Timer




func _on_detection_area_body_entered(Player):
	start()


func _on_detection_area_body_exited(Player):
	stop()
