extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim = get_node("KinematicBody2D/AnimationPlayer")
onready var sprite = get_node("KinematicBody2D/Player")
onready var RayCastLOS = get_node("KinematicBody2D/RayCastLOS")
onready var rc_down = get_node("KinematicBody2D/RayCastDown")
onready var rc_up = get_node("KinematicBody2D/RayCastUp")
onready var rc_left = get_node("KinematicBody2D/RayCastLeft")
onready var rc_right = get_node("KinematicBody2D/RayCastRight")
onready var click_detector = get_node("KinematicBody2D/ClickDetector")

export(int) var str_stat = 10
export(int) var dex_stat = 10
export(int) var int_stat = 10
export(int) var con_stat = 10
export(int) var wis_stat = 10
export(int) var cha_stat = 10


export(float) var SPEED = 200.0

enum STATES { IDLE, FOLLOW, CHASE, ATTACK1, ATTACK2, ATTACK3, STAGGER, DIE, DEAD }
var _state = STATES.IDLE

var path = []
var target_point_world = Vector2()
var target_position = Vector2()

var velocity = Vector2()
var speed_timer = 0
var speed_timer_limit = dex_stat/10#tiles per second
signal health_changed(newhealth);
signal die;
var health = 100;
var current_target;

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_state(STATES.IDLE)
	RayCastLOS.enabled = true
	 # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move_squares(offset):
	translate(offset * 16)
	
func attack1(target):
	var DistanceToEnemy = target.position-position;
	if DistanceToEnemy.length() == 16:
		match DistanceToEnemy.normalized().round():
			Vector2(-0, -1):
				anim.play("attack_up")
			Vector2(-1, -0):
				anim.play("attack_left")
			Vector2(1, -0):
				anim.play("attack_right")
			Vector2(-0, 1): 
				anim.play("attack_down")
		target.change_health(-10) #then target is on adjacent square.

func attack2(target):
	if (target_position-position).length() == 16:
		target.change_health(-10) #then target is on adjacent square.;

func attack3(target):
	if (target_position-position).length() == 16:
		target.change_health(-10) #then target is on adjacent square.
		
func change_health(delta_health):
	if delta_health < 0:
		_change_state(STATES.STAGGER)
	if health + delta_health >= 100:
		health=100
	elif health + delta_health <= 0:
		health= 0
		_change_state(STATES.DIE)
	else:
		health += delta_health
	
	emit_signal("health_changed", health)
	print("changing health by ", delta_health)

func try_move(offset):
	match offset.round():
		Vector2(-0, -1):
			try_move_up()
		Vector2(-1, -0):
			try_move_left()
		Vector2(1, -0):
			try_move_right()
		Vector2(-0, 1): 
			try_move_down()		

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

func is_anim_playing():
	return anim.is_playing()
	





func _change_state(new_state):
	match new_state:
		STATES.FOLLOW:
			path = get_node('../Map/TileMapBackground').return_path(position, target_position)
			if not path or len(path) == 1:
				_change_state(STATES.IDLE)
				return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
			target_point_world = path[1]
		STATES.CHASE:
			path = get_node('../Map/TileMapBackground').return_path(position, current_target.position)
			if not path or len(path) == 1:
				_change_state(STATES.IDLE)
				return
			target_point_world = path[1]
		STATES.ATTACK1:	
			attack1(current_target)
		STATES.ATTACK2:
			attack2(current_target)
		STATES.ATTACK3:
			attack3(current_target)
		STATES.DIE:
			anim.play("die")
			queue_free()
			emit_signal("die")
		STATES.STAGGER:	
			anim.play("stagger")
	_state = new_state


func _process(delta):
	speed_timer += delta
	if (speed_timer > speed_timer_limit):
		speed_timer -= speed_timer_limit
		match _state:
			STATES.FOLLOW:
				var arrived_to_next_point = move_to(target_point_world)
				if arrived_to_next_point:
					path.remove(0)
					if len(path) == 0:
						_change_state(STATES.IDLE)
						return
					target_point_world = path[0]
				# The index 0 is the starting cell
			STATES.CHASE:
				var arrived_to_next_point = move_to(target_point_world)
				if arrived_to_next_point:
					path.remove(0)
					if len(path) == 0:
						_change_state(STATES.IDLE)
						return
					target_point_world = path[0]
			STATES.ATTACK1:	
				attack1(current_target)
			STATES.ATTACK2:
				attack2(current_target)
			STATES.ATTACK3:
				attack3(current_target)
			STATES.DIE:
				pass;
				#anim.play("die")
			STATES.STAGGER:	
				pass;
				#anim.play("stagger")





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
	
	return position.distance_to(world_position) <= ARRIVE_DISTANCE
	
func chase(target):
	current_target = target
	_change_state(STATES.CHASE)

func search(target):
	var DistanceToTarget = target.position - position
	#print(DistanceToTarget)
	RayCastLOS.cast_to = DistanceToTarget
	if RayCastLOS.is_colliding():
		if RayCastLOS.get_collider() == target.get_node("KinematicBody2D"):
			#print("Target Acquired")
			return true




#func _on_ClickDetector_clicked(owner):
#	print("chasing" +owner.name)
#	chase(owner) # Replace with function body.
