extends StaticBody2D


var alive = true
var hatching = false
signal hatched

# Called when the node enters the scene tree for the first time.
func _ready():
	$birb.play("egg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func kill():
	#display blank animation
	print("bird is kill")
	alive = false


func isAlive():
	return alive


func _on_HatchTimer_timeout():
	if hatching:
		$birb.play("hatched")
		emit_signal("hatched")
	else:
		$birb.play("hatching")
		hatching = true
	print("hatch")
	
