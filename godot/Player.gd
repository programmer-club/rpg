
extends Node2D

onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Player")

onready var rc_down = get_node("RayCastDown")
onready var rc_up = get_node("RayCastUp")
onready var rc_left = get_node("RayCastLeft")
onready var rc_right = get_node("RayCastRight")
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
	

func move_squares(offset):
	translate(offset * 16)

