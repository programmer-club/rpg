extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("KinematicBody2D/AnimationPlayer")
onready var sprite = get_node("KinematicBody2D/Player")

onready var rc_down = get_node("KinematicBody2D/RayCastDown")
onready var rc_up = get_node("KinematicBody2D/RayCastUp")
onready var rc_left = get_node("KinematicBody2D/RayCastLeft")
onready var rc_right = get_node("KinematicBody2D/RayCastRight")

export(int) var str_stat = 10
export(int) var dex_stat = 10
export(int) var int_stat = 10
export(int) var con_stat = 10
export(int) var wis_stat = 10
export(int) var cha_stat = 10

signal health_changed(newhealth);
var health = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move_squares(offset):
	translate(offset * 16)
	
func attack1():
	print("Default Player doing attack 1");

func attack2():
	pass;

func attack3():
	pass;
	
func change_health(delta_health):
	if health + delta_health > 100:
		health=100
	elif health + delta_health < 0:
		health= 0
	else:
		health += delta_health
	
	emit_signal("health_changed", health)
	print("changing health by ", delta_health)

func try_move_down():
	if rc_down.is_colliding():
		anim.play("look_down")
	else:
		anim.play("down")
		move_squares(Vector2(0,1))
		
func try_move_right():
	if rc_right.is_colliding():
		anim.play("look_right")
	else:
		anim.play("right")
		move_squares(Vector2(1,0))
func try_move_up():
	if rc_up.is_colliding():
		anim.play("look_up")
	else:
		anim.play("up")
		move_squares(Vector2(0,-1))
		
func try_move_left():
	if rc_left.is_colliding():
		anim.play("look_left")
	else:
		anim.play("left")
		move_squares(Vector2(-1,0))

func is_anim_playng():
	return anim.is_playing()