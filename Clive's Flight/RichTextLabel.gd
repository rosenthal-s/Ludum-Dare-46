extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
var buttonPressed = false
signal stopGame


var ms = 0
var s = 10
var m = 10


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if buttonPressed == true:
		if ms < 0:
			ms = 9
			s -= 1
		
		if s < 0:
			if m >0:
				s = 59
				m -=1
		
		if m <= 0 and s <=0:
			buttonPressed = false
			
		set_text("Time: "+str(m)+":"+str(s))
		
	if m <=0 and s <=0:
		emit_signal("stopGame")
		
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_game_start_timer():
	buttonPressed = true


func _on_GameTimer_timeout():
	ms -= 1
