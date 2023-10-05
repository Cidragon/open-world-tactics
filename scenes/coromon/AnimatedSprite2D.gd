extends AnimatedSprite2D

@onready var grass_overlay_creature: Sprite2D = %grass_overlay_creature

signal change_grass_position(animation_name : String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("animation_changed", _on_animation_changed)

func _on_animation_changed() -> void:
	grass_overlay_creature.update_position(get_animation())
	#change_grass_position.emit(get_animation())

func set_to_idle() -> void:
	match get_animation():
		"walk_up": pass
		"walk_right": play("idle_right")
		"walk_down": pass
		"walk_left": play("idle_left")
