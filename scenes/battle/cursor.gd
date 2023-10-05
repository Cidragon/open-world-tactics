extends Sprite2D

@export var movement_tile : Texture
var walkable_tiles : Array[Sprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var coromon_location = get_parent().coromon_location
	var tile_position = Variables.tilemap.local_to_map(position)
	if walkable_tiles.size() == 0 and tile_position == coromon_location:
		var visited = {}
		dfs_with_max_distance(tile_position, tile_position, 3, visited)
	elif tile_position != coromon_location and walkable_tiles.size() != 0:
		walkable_tiles = []
		for child in get_children():
			child.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		position += Vector2(0,-Variables.tile_size)
	elif event.is_action_pressed("ui_right"):
		position += Vector2(Variables.tile_size,0)
	elif event.is_action_pressed("ui_down"):
		position += Vector2(0,Variables.tile_size)
	elif event.is_action_pressed("ui_left"):
		position += Vector2(-Variables.tile_size,0)

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
