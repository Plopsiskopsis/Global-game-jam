extends Node

onready var tap_tween = $Tap_tween
var selected :Array = []
var needed_types : Array = []

func _ready() -> void:
	Global.level = self
	select_needed_types()

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
	Global.set_types()
	select_needed_types()

func _on_Okay_button_pressed():
	Global.set_types()
	select_needed_types()

func select_needed_types():
	for j in $Tappables.get_child_count():
		$Tappables.get_child(j).select_type()
	needed_types.clear()
	for i in 3:
		var ind :int = randi() % Global.selected_types.size()
		needed_types.append(Global.selected_types[ind])
		Global.selected_types.remove(ind)
	$temp_speech_bubble/Label.text = str(needed_types[0], " ", needed_types[1], " ", needed_types[2])
