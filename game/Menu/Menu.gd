extends Control

func _ready():
	randomize() # for getting random seed in game

func _on_Start_button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Levels/Level.tscn"))
	


func _on_Music_button_pressed():
	MusicPlayer.playing = !MusicPlayer.playing


func _on_Quit_button_pressed():
	get_tree().quit()
