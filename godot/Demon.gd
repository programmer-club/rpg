extends "res://NPC.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("../Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	pass
	var targetFound = search(player)
	if targetFound:
		.chase(player)
		

func _on_ClickDetector_clicked(owner):
	pass