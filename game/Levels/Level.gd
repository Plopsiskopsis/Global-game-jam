extends Node

onready var tap_tween :Object = $Tap_tween
onready var score_lbl :Object = $Score
onready var anim :Object = $AnimationPlayer
onready var shopper_anim :Object = $Shopper_anim
onready var tappable_scn :PackedScene = load("res://Objects/Tappable_object.tscn")
var selected :Array = []
var needed_types : Array = []
var score :int = 0
var selection_available :bool = true

func _ready() -> void:
	Global.level = self
	set_new_hand()
	select_needed_types()

func _on_TextureButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped(obj :Object) -> void:
	tap_tween.interpolate_property(obj, "rect_position", obj.rect_position, Vector2(120.0 + rand_range(0.0, 250.0), 870.0 + rand_range(0.0, 50.0)), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tap_tween.start()
	selected.append(obj)
	if selected.size() >= 3:
		selection_available = false
		$Trash_button.show()
		$Okay_button.show()

func _on_Trash_button_pressed() -> void:
	trash_hand()
	selection_available = true

func _on_Okay_button_pressed() -> void:
	var correct :int = 0
	print(needed_types)
	for y in selected:
		print(y.type)
	for j in needed_types:
		for i in selected:
			if i.type == j:
				correct += 1
	if correct >= needed_types.size():
		score += 1
		score_lbl.text = str(score)
		anim.play("love")
		shopper_anim.play("new_shopper")
	else:
		score -= 1
		score_lbl.text = str(score)
		anim.play("hate")
		shopper_anim.play("new_shopper")
	trash_hand()
	selection_available = true

func trash_hand() -> void:
	for i in $Tappables.get_child_count():
		$Tappables.get_child(i).trash()
	selected.clear()
	$Trash_button.hide()
	$Okay_button.hide()
	Global.set_types()
	set_new_hand()
	select_needed_types()

func set_new_hand() -> void:
	for j in Global.ingredient_types.size():
		var tappable :Object = tappable_scn.instance()
		tappable.rect_position.x = rand_range(20.0, 460.0)
		tappable.rect_position.y = rand_range(490.0, 820.0)
		$Tappables.add_child(tappable)

func select_needed_types() -> void:
	$Requested_item.select_requested_item()
#	for j in $Tappables.get_child_count():
#		$Tappables.get_child(j).select_type()
	needed_types.clear()
	match $Requested_item.requested_type:
		"Black powder":
			needed_types.append("Ash")
			needed_types.append("Bat wing")
			needed_types.append("Dragon scale")
		"Fire feather": 
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
