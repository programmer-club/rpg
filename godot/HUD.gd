extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var number_label = $Label
onready var bar = $ProgressBar
onready var tween = $Tween
# Called when the node enters the scene tree for the first time.
#func _ready():
    #var player_max_health = $"../Characters/Player".max_health
    #bar.max_value = player_max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	



func _on_Knight_health_changed(newhealth):
	tween.interpolate_property(bar, "value", bar.value, newhealth, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0) 
	print("setting health bar to ", newhealth)
	if not tween.is_active():
    	tween.start()
