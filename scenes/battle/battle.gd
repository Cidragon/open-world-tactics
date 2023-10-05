extends Node2D

@onready var cursor: Sprite2D = %cursor

var coromon_location : Vector2i

func _ready() -> void:
	cursor.show_battle_ui.connect(show_battle_ui)

func show_battle_ui() -> void:
	print("showing battle ui")
