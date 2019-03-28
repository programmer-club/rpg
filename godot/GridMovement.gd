extends Node2D

# using export makes it possible to edit the variable in the inspector
export(float) var speed = 10.0     
export(int) var tileSize = 16    

# store target and initial position to move to and from.
var target = Vector2()
var initial = Vector2()

# store the input from arrow keys to allow movement
var inp = Vector2()

# stores time that is incremented by delta
var d = 0 


func _process(delta):
    var val = d * speed
    # use the val to move from initial to final position
    if val >= 1.0: 
        val = 1
        d = 0
    # set the position equal to the lerp between initial and target position
    self.position.x = lerp(initial.x, target.x, val)
    self.position.y = lerp(initial.y, target.y, val)
    # check and see if the input is zero
    if inp.length() != 0:
        # setup initial and target position using tileSize and inp
        initial = self.position
        # using "self." is not necessary just for better readability
        target = initial + tileSize * inp
        # reset inp = (0,0)
        inp = Vector2()
    elif self.position == target:
        # if input is zero and target is reached start taking inputs again
        get_input_dir()
    else:
        # as delta is time from last from so if you keep adding it will reach
        # 1 when the total time elapsed is 1 second. So it is just time in secs.
        d += delta

func get_input_dir():
    # this check allows for only 4-way motion,
    if inp.x == 0:
        # convert boolean to int to use them to get the input direction
        inp.y = (int(Input.is_action_pressed("down"))
                                    - int(Input.is_action_pressed("up")))
    if inp.y == 0:
        # convert boolean to int to use them to get the input direction
        inp.x = (int(Input.is_action_pressed("right"))
                                  - int(Input.is_action_pressed("left")))

