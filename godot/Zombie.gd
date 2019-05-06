extends "res://NPC.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("../Player").get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass#chase(player) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var targetFound = search(player)
	if targetFound:
		.chase(player)

func _on_ClickDetector_clicked(owner):
	pass
                #Do what ever you do when a player is detected



