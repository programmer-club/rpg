extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal clicked(owner)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		emit_signal("clicked", get_parent())
		print("Clicked")