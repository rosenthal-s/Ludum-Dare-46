extends TextureButton


signal start_timer
func _ready():
	pass # Replace with function body.




func _on_start_game_pressed():
	self.queue_free()
	emit_signal("start_timer")



