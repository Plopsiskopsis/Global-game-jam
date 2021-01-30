extends Node

var level :Object

var ingredient_types :Array = []
var selected_types :Array = []

var requestable_items :Array = ["Black powder", "Fire feather", "Flower potion",
 "Jelly potion", "Purple pendant"]

func _ready() -> void:
	set_types()

func set_types() ->void:
	selected_types.clear()
	ingredient_types = ["Amber", "Ash", "Bat wing", "Berries", 
	"Dragon scale", "Feather", "Flower", "Jelly", "Mushroom"]
	
