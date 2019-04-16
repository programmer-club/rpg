extends Node2D

var zombie_resource = preload("res://Zombie.tscn")
var demon_resource = preload("res://Demon.tscn")
var half_cell = Vector2(8,8)
func _ready():
	add_Zombie(Vector2(5,12), "Bob the Zombie")
	add_Demon(Vector2(13,11), "Dan the Demon")
	print("Summoning Zombie")
	
func add_Zombie(position, name):
	var new_zombie = zombie_resource.instance() 
	add_child(new_zombie)#Create new zombie from scene
	new_zombie.set_name(name)
	new_zombie.set_position((position * 16) + half_cell) #move it to starting position in grid squares
	new_zombie.get_node("KinematicBody2D/ClickDetector").connect("clicked", $Knight, "on_ClickDetector_clicked")
	new_zombie.show()
	print(has_node(name))
	
func add_Demon(position, name):
	var new_demon = demon_resource.instance() 
	add_child(new_demon)#Create new zombie from scene
	new_demon.set_name(name)
	new_demon.set_position((position * 16) + half_cell) #move it to starting position in grid squares
	new_demon.get_node("KinematicBody2D/ClickDetector").connect("clicked", $Knight, "on_ClickDetector_clicked")
	new_demon.show()
	print(has_node(name))