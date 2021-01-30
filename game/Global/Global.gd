extends Node

var level :Object

var ingredient_types :Array = []

func _ready():
	set_types()

func set_types():
	ingredient_types = ["Amber", "Ash", "Bat Wing", "Berries", 
	"Dragon Scale", "Feather", "Flower", "Jelly", "Mushroom"]
