extends TextureButton

onready var anim = $AnimationPlayer

func _ready() -> void:
	select_type()

func _on_Tappable_object_pressed() -> void:
	anim.play("tapped")
	Global.level.tapped(self)

func select_type() -> void:
	modulate = Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0), 1.0)
