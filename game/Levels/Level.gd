extends Node 

func _ready():
	Global.level = self

func _on_TextureButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped():
	print("tapidi tap")
