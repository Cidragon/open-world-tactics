extends Sprite2D

signal show_battle_ui()

@export var movement_tile : Texture
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

var walkable_tiles : Array[Sprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var coromon_location = Vector2i(9,9)
	var tile_position = Variables.tilemap.local_to_map(position)
	print("coromon position: " + str(coromon_location))
	print("tile_position: " + str(tile_position))
	var distance = abs(tile_position.x - coromon_location.x) + abs(tile_position.y - coromon_location.y)
	var min_path : Array[Vector2i]= []
	for i in range(distance+1):
		min_path.append(Vector2i(0,0))
	
	print(min_path.size())
	print(dfs_shortest_path(coromon_location, tile_position, [], min_path, {}))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var coromon_location = get_parent().coromon_location
	var tile_position = Variables.tilemap.local_to_map(position)
	#print(coromon_location)
	#print(tile_position)
	
	print(dfs_shortest_path(coromon_location, tile_position, [], [], {}))
	
	if walkable_tiles.size() == 0 and tile_position == coromon_location:
		var visited = {}
		dfs_with_max_distance(tile_position, tile_position, 3, visited)
	elif tile_position != coromon_location and walkable_tiles.size() != 0:
		for child in walkable_tiles:
			child.queue_free()
		walkable_tiles = []

func update_sprites(update_frame : int) -> void:
	animated_sprite_2d.visible = true
	animated_sprite_2d.frame = update_frame
	animated_sprite_2d.play("walk_right")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		position += Vector2(0,-Variables.tile_size)
	elif event.is_action_pressed("ui_right"):
		position += Vector2(Variables.tile_size,0)
	elif event.is_action_pressed("ui_down"):
		position += Vector2(0,Variables.tile_size)
	elif event.is_action_pressed("ui_left"):
		position += Vector2(-Variables.tile_size,0)
	
	
	if event.is_action_pressed("accept"):
		var coromon_location = get_parent().coromon_location
		var tile_position = Variables.tilemap.local_to_map(position)
		if coromon_location == tile_position:
			show_battle_ui.emit()
	elif event.is_action_pressed("cancel"):
		pass

func dfs_with_max_distance(tile_position: Vector2i, tile : Vector2i, max_distance: int, visited : Dictionary):
	var distance = abs(tile_position.x - tile.x) + abs(tile_position.y - tile.y)
	if distance > max_distance:
		return
	if tile in visited:
		return
	
	visited[tile] = distance
	var sprite := Sprite2D.new()
	sprite.texture = movement_tile
	sprite.position = tile * Variables.tile_size - Vector2i(position.x, position.y)
	sprite.z_index = -1
	sprite.centered = false
	walkable_tiles.push_back(sprite)
	add_child(sprite)
	
	if tile.x > 0:
		var next_tile : Vector2i = tile + Vector2i(-1,0)
		dfs_with_max_distance(tile_position, next_tile, max_distance, visited)
	if tile.x < 32:
		var next_tile : Vector2i = tile + Vector2i(1,0)
		dfs_with_max_distance(tile_position, next_tile, max_distance, visited)
	if tile.y > 0:
		var next_tile : Vector2i = tile + Vector2i(0,-1)
		dfs_with_max_distance(tile_position, next_tile, max_distance, visited)
	if tile.y < 16:
		var next_tile : Vector2i = tile + Vector2i(0,1)
		dfs_with_max_distance(tile_position, next_tile, max_distance, visited)

func dfs_shortest_path(tile_position: Vector2i, objective: Vector2i, current_path : Array[Vector2i], min_path: Array[Vector2i], visited : Dictionary, distance : int = 0) -> Array[Vector2i]:
	if tile_position.x < 0 or tile_position.x > 32 or tile_position.y < 0 or tile_position.y > 16:
		return min_path
	
	if tile_position in visited:
		return min_path
	
	if distance > 4:
		return min_path
	
	current_path.append(tile_position)
	visited[tile_position] = null
	
	if tile_position == objective:
		if min_path.size() == 0 or current_path.size() < min_path.size():
			min_path.clear()
			for i in range(current_path.size()):
				min_path.append(current_path[i])

		return min_path
	
	
	dfs_shortest_path(tile_position + Vector2i(-1,0), objective, current_path, min_path, visited, distance + 1)
	dfs_shortest_path(tile_position + Vector2i(1,0), objective, current_path, min_path, visited, distance + 1)
	dfs_shortest_path(tile_position + Vector2i(0,-1), objective, current_path, min_path, visited, distance + 1)
	dfs_shortest_path(tile_position + Vector2i(0,0), objective, current_path, min_path, visited, distance + 1)
	
	current_path.pop_back()
	return min_path
