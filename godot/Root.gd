extends Node2D

var zombie_resource = preload("res://Zombie.tscn")

func _ready():
	add_Zombie(Vector2(-12,5))
	
func add_Zombie(position):
	var new_zombie = zombie_resource.instance() #Create new zombie from scene
	new_zombie.set_pos(position * 16) #move it to starting position in grid squares
	new_zombie.get_node("KinematicBody2D/ClickDetector").connect("clicked", $Knight, "on_ClickDetector_clicked")