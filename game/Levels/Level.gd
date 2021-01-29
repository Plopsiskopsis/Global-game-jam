extends Node 

onready var tap_tween = $Tap_tween

func _ready() -> void:
	Global.level = self

func _on_TextureButton_pressed() -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(load("res://Menu/Menu.tscn"))

func tapped(obj :Object) -> void:
	tap_tween.interpolate_property(obj, "rect_position", obj.rect_position, Vector2(478.0 + rand_range(-32.0, 32.0), 300.0 + rand_range(-32.0, 32.0)), 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tap_tween.start()
