
extends "res://Character.gd"


func _ready():
	set_process_input(true)

func _input(event):
	if not .is_anim_playing():
		if event.is_action_pressed("ui_down"):
			.try_move_down()
		if event.is_action_pressed("ui_up"):
			.try_move_up()
		if event.is_action_pressed("ui_left"):
			.try_move_left()
		if event.is_action_pressed("ui_right"):
			.try_move_right()
		if event.is_action_pressed("attack1"):
			.attack1()
		if event.is_action_pressed("attack2"):
			.attack2()
		if event.is_action_pressed("attack3"):
			.attack3()
		if event.is_action_pressed("health_increase"):
			.change_health(1)
		if event.is_action_pressed("health_decrease"):
			.change_health(-1)
		if event.is_action_pressed('click'):
			if Input.is_key_pressed(KEY_SHIFT):
				global_position = get_global_mouse_position()
			else:
				target_position = get_global_mouse_position()
				_change_state(STATES.FOLLOW)							
	


