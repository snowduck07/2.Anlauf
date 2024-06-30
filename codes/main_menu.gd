extends Node2D

func _ready():
	$menu_buttons/start.grab_focus()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_fullscreen_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_pressed():
	get_tree().quit()
