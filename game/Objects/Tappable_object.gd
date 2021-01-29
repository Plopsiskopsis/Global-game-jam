extends TextureButton

onready var anim = $AnimationPlayer

func _ready():
	select_type()

func _on_Tappable_object_pressed():
	anim.play("tapped")
	Global.level.tapped()

func select_type():
	modulate = Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0), 1.0)
