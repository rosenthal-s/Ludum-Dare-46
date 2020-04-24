extends StaticBody2D

var playerScore = 0

func _on_Timer_timeout():
	if playerScore < 4:
		self.call_deferred('free')


func _on_detection_area_body_entered(body):
	playerScore = body.getScore()
	if playerScore < 4:
		$AnimatedSprite.play("wobble")


func _on_detection_area_body_exited(body):
	$AnimatedSprite.play("default")
