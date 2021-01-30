extends Sprite

var requested_type :String

func select_requested_item() -> void:
	requested_type = Global.requestable_items[randi() % Global.requestable_items.size()]
	match requested_type:
		"Black powder":
			texture = load("res://Objects/Graphics/Item_Black_Powder.png")
		"Fire feather": 
			texture = load("res://Objects/Graphics/Item_Fire_Feather.png")
		"Flower potion":
			texture = load("res://Objects/Graphics/Item_Flower_Potion.png")
		"Jelly potion": 
			texture = load("res://Objects/Graphics/Item_Jelly_Potion.png")
		"Purple pendant":
			texture = load("res://Objects/Graphics/Item_Purple_Pendant.png")
