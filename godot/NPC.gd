extends "res://Character.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var RayCastLOS = get_node("KinematicBody2D/RayCastLOS")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func search(target):
	var DistanceToTarget = target.position - position
	RayCastLOS.cast_to = DistanceToTarget
	if RayCastLOS.is_colliding():
		if RayCastLOS.get_collider() == target:
			print("Target Acquired")
			return true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
