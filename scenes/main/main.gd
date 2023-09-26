extends Node2D

@onready var player : CharacterBody2D= %CharacterBody2D
@onready var tilemap : TileMap = %background


func _ready() -> void:
	player.tilemap = tilemap


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
