extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_help_button_down():
	set_text("How to play:\n	- Use your mouse to control 		the father bird\n	- Keep your chicks alive by 		keeping them fed\n	- Enemy birds will steal your 		chicks' food from the nest\nFeeding:\n	- Fly and hover near the 			cherries to pick them  \n	- Fly over nest to feed chicks 			with collected food\nEnemies:\n	 - Right click to Squawk at 		enemy birds to scare them 		away")




func _on_help_button_up():
	clear()



