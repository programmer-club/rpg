extends Control

# load the RPG library
onready var data = preload("res://bin/rpg.gdns").new()

func _on_Button_pressed():
    $Label.text = "Data = " + data.get_data()