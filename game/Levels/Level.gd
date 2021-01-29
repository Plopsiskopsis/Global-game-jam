extends Node

onready var tap_tween = $Tap_tween
var selected :Array

func _ready() -> void:
	Global.level = self

func _on_TextureButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped(obj :Object) -> void:
	tap_tween.interpolate_property(obj, "rect_position", obj.rect_position, Vector2(478.0 + rand_range(-32.0, 32.0), 300.0 + rand_range(-32.0, 32.0)), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tap_tween.start()
	selected.append(obj)
	if selected.size() >= 3:
		$Trash_button.show()
		$Okay_button.show()

func _on_Trash_button_pressed():
	for i in selected:
		i.trash()
	selected.clear()
	$Trash_button.hide()
	$Okay_button.hide()

func _on_Okay_button_pressed():
	print(selected)
	
