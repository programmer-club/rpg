extends "res://Character.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var RayCastLOS = get_node("KinematicBody2D/RayCastLOS")
# Called when the node enters the scene tree for the first time.
func _ready():
	RayCastLOS.enabled = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
