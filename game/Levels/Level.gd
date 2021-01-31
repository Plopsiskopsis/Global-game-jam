extends Node

onready var tap_tween :Object = $Tap_tween
onready var score_lbl :Object = $Score
onready var anim :Object = $AnimationPlayer
onready var shopper_anim :Object = $Shopper_anim
onready var tappable_scn :PackedScene = load("res://Objects/Tappable_object.tscn")

var npc :int = 1
var selected :Array = []
var needed_types : Array = []
var selection_available :bool = true
var time :float = 120.0

func _process(delta):
	time -= delta
	$Time_label.text = str("Time ", int(time))
	if time <= 0:
		get_tree().change_scene_to(load("res://Levels/Game_over_screen.tscn"))

func _ready() -> void:
	Global.score = 0
	Global.level = self
	set_new_hand()
	select_needed_types()

func _on_TextureButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped(obj :Object) -> void:
	tap_tween.interpolate_property(obj, "rect_position", obj.rect_position, Vector2(130.0 + rand_range(0.0, 200.0), 870.0 + rand_range(0.0, 70.0)), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
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
#	print(needed_types)
#	for y in selected:
#		print(y.type)
	for j in needed_types:
		for i in selected:
			if i.type == j:
				correct += 1
	if correct >= needed_types.size():
		Global.score += 1
		score_lbl.text = str(Global.score)
		if npc == 1:
			anim.play("love1")
			shopper_anim.play("new_shopper1")
		else:
			anim.play("love2")
			shopper_anim.play("new_shopper2")
	else:
		Global.score -= 1
		score_lbl.text = str(Global.score)
		if npc == 1:
			anim.play("hate1")
			shopper_anim.play("new_shopper1")
		else:
			anim.play("hate2")
			shopper_anim.play("new_shopper2")
	trash_hand()
	selection_available = true

func select_shopper():
	if randi() % 2 == 0:
		npc = 1
		$Top_center/NPC.texture = load("res://Objects/Graphics/NPC_1_Default.png")
		shopper_anim.play("enter_shopper1")
	else:
		npc = 2
		$Top_center/NPC.texture = load("res://Objects/Graphics/NPC_2_Default.png")
		shopper_anim.play("enter_shopper2")

func trash_hand() -> void:
	for i in get_tree().get_nodes_in_group("TAPPABLE"):
		i.trash()
	selected.clear()
	$Trash_button.hide()
	$Okay_button.hide()
	Global.set_types()
	set_new_hand()
	select_needed_types()

func set_new_hand() -> void:
	for j in get_tree().get_nodes_in_group("POS"):
		var tappable :Object = tappable_scn.instance()
		tappable.rect_position = j.position
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
	var rando :int = randi() % 2
	match rando:
		0:
			$temp_speech_bubble/Label.text = str("???", " ", needed_types[1], " ", needed_types[2])
		1:
			$temp_speech_bubble/Label.text = str(needed_types[0], " ", "???", " ", needed_types[2])
		2:
			$temp_speech_bubble/Label.text = str(needed_types[0], " ", needed_types[1], " ", "???")
