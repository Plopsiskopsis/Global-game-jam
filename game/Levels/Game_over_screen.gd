extends Control

func _ready():
	$CenterContainer/VBoxContainer/Label2.text = str("Your score was ", int(Global.score))

func _on_TextureButton_pressed():
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))
