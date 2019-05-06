extends Node2D
onready var player = $Player
var zombie_resource = preload("res://Zombie.tscn")
var demon_resource = preload("res://Demon.tscn")
var wizard_resource = preload("res://Wizard.tscn")
var knight_resource = preload("res://Knight.tscn")
var half_cell = Vector2(8,8)
enum PLAYERTYPES {KNIGHT, WIZARD}
var current_player_type = PLAYERTYPES.KNIGHT
func _ready():
	add_Zombie(Vector2(5,12), "Bob the Zombie")
	add_Demon(Vector2(13,11), "Dan the Demon")
	add_Player(Vector2(2,3), "Pete the Player", PLAYERTYPES.KNIGHT)
	change_Player_type(current_player_type)
	print("Summoning Zombie")
	
func add_Zombie(position, name):
	var new_zombie = zombie_resource.instance() 
	add_child(new_zombie)#Create new zombie from scene
	new_zombie.set_name(name)
	new_zombie.set_position((position * 16) + half_cell) #move it to starting position in grid squares
	new_zombie.get_node("KinematicBody2D/ClickDetector").connect("clicked", $Player, "on_ClickDetector_clicked")
	new_zombie.show()
	print(has_node(name))
	
func add_Demon(position, name):
	var new_demon = demon_resource.instance() 
	add_child(new_demon)#Create new zombie from scene
	new_demon.set_name(name)
	new_demon.set_position((position * 16) + half_cell) #move it to starting position in grid squares
	new_demon.get_node("KinematicBody2D/ClickDetector").connect("clicked", $Player, "on_ClickDetector_clicked")
	new_demon.show()
	print(has_node(name))

func add_Player(position, name, type):
	change_Player_type(type)
	player.set_position(position * 16 + half_cell)
	player.show()

func change_Player_type(type):
	match type:
		PLAYERTYPES.KNIGHT:
			player.add_child(knight_resource.instance())
			player.get_child(1).set_position(player.get_child(0).position);
			
			player.remove_child(player.get_child(0))
			current_player_type = PLAYERTYPES.KNIGHT
		PLAYERTYPES.WIZARD:
			player.add_child(wizard_resource.instance())
			player.get_child(1).set_position(player.get_child(0).position);
			
			player.remove_child(player.get_child(0))
			
			current_player_type = PLAYERTYPES.WIZARD
			
	
	
	
	