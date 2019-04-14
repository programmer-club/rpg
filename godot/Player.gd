
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
			._change_state(STATES.ATTACK1)
		if event.is_action_pressed("attack2"):
			._change_state(STATES.ATTACK2)
		if event.is_action_pressed("attack3"):
			._change_state(STATES.ATTACK3)
		#if event.is_action_pressed("health_increase"):
			#.change_health(1)
		#if event.is_action_pressed("health_decrease"):
			#.change_health(-1)
#		if event.is_action_pressed('click'):
#			
#				target_position = get_global_mouse_position()
#				_change_state(STATES.FOLLOW)							
				
func on_ClickDetector_clicked(owner):
	current_target = owner
	print("Chasing " + owner)
	_change_state(STATES.CHASE)
	


