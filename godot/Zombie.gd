extends "res://NPC.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var player = get_node("../Knight")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var targetFound = search(player)
	if targetFound:
		chase(player)


                #Do what ever you do when a player is detected

func chase(target):
	target_position = target.position
	_change_state(STATES.FOLLOW)

