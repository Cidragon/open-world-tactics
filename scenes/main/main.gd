extends Node2D

@onready var player : Area2D= %CharacterBody2D
@onready var tilemap : TileMap = %background
@onready var world : Node2D = %world
@onready var battle_effect : TileMap = %Battle_effect


func _ready() -> void:
	player.tilemap = tilemap
	player.pause_world.connect(pause_world)
	Variables.tilemap = tilemap

func pause_world() -> void:
	world.process_mode = Node.PROCESS_MODE_DISABLED
	tilemap.pause_animation()
	%Battle_effect.show_battle_effect()
