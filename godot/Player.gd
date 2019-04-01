
extends Node2D

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

func _ready():
	set_process_input(true)

func _input(event):
	if not anim.is_playing():
		if event.is_action_pressed("ui_down"):
			if rc_down.is_colliding():
				anim.play("look_down")
			else:
				anim.play("down")
				move_squares(Vector2(0,1))
		if event.is_action_pressed("ui_up"):
			if rc_up.is_colliding():
				anim.play("look_up")
			else:
				anim.play("up")
				move_squares(Vector2(0,-1))
		if event.is_action_pressed("ui_left"):
			if rc_left.is_colliding():
				anim.play("look_left")
			else:
				anim.play("left")
				move_squares(Vector2(-1,0))
		if event.is_action_pressed("ui_right"):
			if rc_right.is_colliding():
				anim.play("look_right")
			else:
				anim.play("right")
				move_squares(Vector2(1,0))
		if event.is_action_pressed("attack1"):
			attack1()
		if event.is_action_pressed("attack2"):
			attack2()
		if event.is_action_pressed("attack3"):
			attack3()
		if event.is_action_pressed("health_increase"):
			change_health(1)
		if event.is_action_pressed("health_decrease"):
			change_health(-1)						
	

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
