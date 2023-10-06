extends Node2D

@onready var bee: Node2D = %bee
@onready var cursor: Sprite2D = %cursor

var coromon_location : Vector2i

func _ready() -> void:
	cursor.show_battle_ui.connect(show_battle_ui)
	var x : int = (int(bee.position.x))
	var y : int = (int(bee.position.y))
	var tile_position : Vector2i = Variables.tilemap.local_to_map(Vector2i(x,y))
	coromon_location = tile_position

func show_battle_ui() -> void:
	cursor.update_sprites(bee.animated_sprite.frame)
	print(coromon_location)
	print("showing battle ui")
