extends AnimatedSprite2D

signal change_grass_position(animation_name : String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("animation_changed", _on_animation_changed)

func _on_animation_changed() -> void:
	change_grass_position.emit(get_animation())

func set_to_idle() -> void:
	pass
