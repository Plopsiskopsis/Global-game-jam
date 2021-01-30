extends TextureButton

onready var anim = $AnimationPlayer
var type :String

func _ready() -> void:
	select_type()

func _on_Tappable_object_pressed() -> void:
	if Global.level.selection_available:
		anim.play("tapped")
		Global.level.tapped(self)

func trash() -> void:
	anim.play("trash")

func select_type() -> void:
	var ind :int = randi() % Global.ingredient_types.size()
	type = Global.ingredient_types[ind]
	Global.selected_types.append(type)
	#print(type)
	match type:
		"Amber":
			texture_normal = load("res://Objects/Graphics/Ingredient_Amber.png")
		"Ash":
			texture_normal = load("res://Objects/Graphics/Ingredient_Ash.png")
		"Bat wing":
			texture_normal = load("res://Objects/Graphics/Ingredient_BatWing.png")
		"Berries":
			texture_normal = load("res://Objects/Graphics/Ingredient_Berries.png")
		"Dragon scale":
			texture_normal = load("res://Objects/Graphics/Ingredient_DragonScale.png")
		"Feather":
			texture_normal = load("res://Objects/Graphics/Ingredient_Feather.png")
		"Flower":
			texture_normal = load("res://Objects/Graphics/Ingredient_Flower.png")
		"Jelly":
			texture_normal = load("res://Objects/Graphics/Ingredient_Jelly.png")
		"Mushroom":
			texture_normal = load("res://Objects/Graphics/Ingredient_Mushroom.png")
	Global.ingredient_types.remove(ind)
	modulate = Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0), 1.0)

