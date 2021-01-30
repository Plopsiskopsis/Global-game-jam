extends Node

onready var tap_tween = $Tap_tween
onready var tappable_scn :PackedScene = load("res://Objects/Tappable_object.tscn")
var selected :Array = []
var needed_types : Array = []

func _ready() -> void:
	Global.level = self
	set_new_hand()
	select_needed_types()

func _on_TextureButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped(obj :Object) -> void:
	tap_tween.interpolate_property(obj, "rect_position", obj.rect_position, Vector2(446.0 + rand_range(-64.0, 128.0), 280.0 + rand_range(-40.0, 20.0)), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tap_tween.start()
	selected.append(obj)
	if selected.size() >= 3:
		$Trash_button.show()
		$Okay_button.show()

func _on_Trash_button_pressed():
	trash_hand()

func _on_Okay_button_pressed():
	trash_hand()

func trash_hand():
	for i in $Tappables.get_child_count():
		$Tappables.get_child(i).trash()
	selected.clear()
	$Trash_button.hide()
	$Okay_button.hide()
	Global.set_types()
	set_new_hand()
	select_needed_types()

func set_new_hand():
	for j in Global.ingredient_types.size():
		var tappable :Object = tappable_scn.instance()
		tappable.rect_position.x = rand_range(40.0, 980.0)
		tappable.rect_position.y = rand_range(390.0, 560.0)
		$Tappables.add_child(tappable)

func select_needed_types():
	$Requested_item.select_requested_item()
#	for j in $Tappables.get_child_count():
#		$Tappables.get_child(j).select_type()
	needed_types.clear()
	match $Requested_item.requested_type:
		"Black powder":
			needed_types.append("ash")
			needed_types.append("Bat wing")
			needed_types.append("Dragon scale")
		"Fire Feather": 
			needed_types.append("Feather")
			needed_types.append("Amber")
			needed_types.append("Ash")
		"Jelly potion": 
			needed_types.append("Jelly")
			needed_types.append("Berries")
			needed_types.append("Mushroom")
		"Flower potion":
			needed_types.append("Flower")
			needed_types.append("Dragon scale")
			needed_types.append("Jelly")
		"Purple pendant":
			needed_types.append("Amber")
			needed_types.append("Dragon scale")
			needed_types.append("Ash")
	$temp_speech_bubble/Label.text = str(needed_types[0], " ", needed_types[1], " ", needed_types[2])
