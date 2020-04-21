extends StaticBody2D



func _on_Timer_timeout():
	self.call_deferred('free')


func _on_detection_area_body_entered(body):
	$AnimatedSprite.play("wobble")


func _on_detection_area_body_exited(body):
	$AnimatedSprite.play("default")
