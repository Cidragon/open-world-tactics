extends Node2D

@onready var player : CharacterBody2D= %CharacterBody2D
@onready var tilemap : TileMap = %background


func _ready() -> void:
	player.tilemap = tilemap
	Variables.tilemap = tilemap
