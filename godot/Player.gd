
extends Node2D

onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Player")

onready var rc_down = get_node("RayCastDown")
onready var rc_up = get_node("RayCastUp")
onready var rc_left = get_node("RayCastLeft")
onready var rc_right = get_node("RayCastRight")

export(int) var str_stat = 10
export(int) var dex_stat = 10
export(int) var int_stat = 10
export(int) var con_stat = 10
export(int) var wis_stat = 10
export(int) var cha_stat = 10

signal health_changed();
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
	

func move_squares(offset):
	translate(offset * 16)
	
func attack1():
	print("Default Player doing attack 1");

func attack2():
	pass;

func attack3():
	pass;
