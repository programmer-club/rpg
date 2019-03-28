extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right') && this.testMove:
        velocity.x += 1
    elif Input.is_action_pressed('left'):
        velocity.x -= 1
    elif Input.is_action_pressed('down'):
        velocity.y += 1
    elif Input.is_action_pressed('up'):
        velocity.y -= 1
    velocity = velocity.snapped( * speed

func _physics_process(delta):
    get_input()
    move_and_slide(velocity)
	