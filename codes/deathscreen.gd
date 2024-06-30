extends Node2D

func _ready():
	$restart.grab_focus()

func _on_resart_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
