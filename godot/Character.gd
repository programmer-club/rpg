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

export(float) var SPEED = 200.0

enum STATES { IDLE, FOLLOW }
var _state = null

var path = []
var target_point_world = Vector2()
var target_position = Vector2()

var velocity = Vector2()
var speed_timer = 0
var speed_timer_limit = dex_stat/10#tiles per second
signal health_changed(newhealth);
var health = 100;

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_state(STATES.IDLE)
	 # Replace with function body.

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

func try_move(offset):
	if offset.round() == Vector2(-0, -1):
		try_move_up()
	if offset.round() == Vector2(-1, -0):
		try_move_left()
	if offset.round() == Vector2(1, -0):
		try_move_right()
	if offset.round() == Vector2(-0, 1): 
		try_move_down()		

func try_move_down():
#	if rc_down.is_colliding():
#		anim.play("look_down")
#	else:
		anim.play("down")
		move_squares(Vector2(0,1))
		
func try_move_right():
#	if rc_right.is_colliding():
#		anim.play("look_right")
#	else:
		anim.play("right")
		move_squares(Vector2(1,0))
func try_move_up():
#	if rc_up.is_colliding():
#		anim.play("look_up")
#	else:
		anim.play("up")
		move_squares(Vector2(0,-1))
		
func try_move_left():
#	if rc_left.is_colliding():
#		anim.play("look_left")
#	else:
		anim.play("left")
		move_squares(Vector2(-1,0))

func is_anim_playing():
	return anim.is_playing()
	





func _change_state(new_state):
	if new_state == STATES.FOLLOW:
		path = get_node('../Map/TileMapBackground').return_path(position, target_position)
		if not path or len(path) == 1:
			_change_state(STATES.IDLE)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = path[1]
	_state = new_state


func _process(delta):
	speed_timer += delta
	if (speed_timer > speed_timer_limit):
		speed_timer -= speed_timer_limit
		if not _state == STATES.FOLLOW:
			return
		var arrived_to_next_point = move_to(target_point_world)
		if arrived_to_next_point:
			path.remove(0)
			if len(path) == 0:
				_change_state(STATES.IDLE)
				return
			target_point_world = path[0]





func move_to(world_position):
	var direction = (world_position-position).snapped(Vector2.UP).snapped(Vector2.RIGHT) * SPEED
	#var MASS = 10.0
	var ARRIVE_DISTANCE = 0.0
	try_move(direction.normalized())#Vector2(direction.project(Vector2.RIGHT).normalized().x,direction.project(Vector2.UP).normalized().y).normalized().round())
	#var desired_velocity = (world_position - position).normalized() * SPEED
	#var steering = desired_velocity - velocity
	#velocity += steering / MASS
	#position += velocity * get_process_delta_time()
	#rotation = velocity.angle() 
	print (direction.normalized())
	
	return position.distance_to(world_position) <= ARRIVE_DISTANCE


func _input(event):
	if event.is_action_pressed('click'):
		if Input.is_key_pressed(KEY_SHIFT):
			global_position = get_global_mouse_position()
		else:
			target_position = get_global_mouse_position()
		_change_state(STATES.FOLLOW)	
