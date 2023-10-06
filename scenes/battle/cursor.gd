extends Sprite2D

signal show_battle_ui()

@export var arrow_tiles : Array[Texture]
@export var movement_tile : Texture
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


var walkable_tiles : Array[Sprite2D] = []
var path_sprites : Array[Sprite2D] = []
var max_distance : int = 6
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var coromon_location = get_parent().coromon_location
	var tile_position = Variables.tilemap.local_to_map(position)
	#print(coromon_location)
	#print(tile_position)
	
	var path : Array[Vector2i]= bfs_shortest_path(coromon_location, tile_position, {})
	
	create_path_sprites(path)
	
	if walkable_tiles.size() == 0 and tile_position == coromon_location:
		var visited = {}
		dfs_with_max_distance(tile_position, tile_position, max_distance, visited)
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

func bfs_shortest_path(start_position: Vector2i, objective_position : Vector2i, visited : Dictionary) -> Array[Vector2i]:
	var queue = [[start_position, [start_position] as Array[Vector2i]]]
	
	while queue:
		var pop = queue.pop_front()
		var current : Vector2i = pop[0]
		var path : Array[Vector2i] = pop[1]
		
		if current == objective_position:
			print(path)
			return path
		
		if current.y > 0:
			var up : Vector2i = current + Vector2i(0,-1)
			if not up in visited:
				var arr : Array[Vector2i] = path.duplicate(true)
				arr.push_back(up)
				queue.push_back([up, arr])
				visited[up] = null
		if current.y < 16:
			var down : Vector2i = current + Vector2i(0,1)
			if not down in visited:
				var arr : Array[Vector2i] = path.duplicate(true)
				arr.push_back(down)
				queue.push_back([down, arr])
				visited[down] = null
		if current.x > 0:
			var left : Vector2i = current + Vector2i(-1,0)
			if not left in visited:
				var arr : Array[Vector2i] = path.duplicate(true)
				arr.push_back(left)
				queue.push_back([left, arr])
				visited[left] = null
		if current.x < 32:
			var right : Vector2i = current + Vector2i(1,0)
			if not right in visited:
				var arr : Array[Vector2i] = path.duplicate(true)
				arr.push_back(right)
				queue.push_back([right, arr])
				visited[right] = null
	
	return []

func create_path_sprites(path: Array[Vector2i]) -> void:
	for sprite in path_sprites:
		sprite.queue_free()
	
	path_sprites.clear()
	
	var tile_position = Variables.tilemap.local_to_map(position)
	for i in range(1, path.size()):
		var sprite = Sprite2D.new()
		sprite.texture = arrow_tiles[0]
		sprite.centered = false
		sprite.position = (path[i] - tile_position) * Variables.tile_size
		
		var diff_position : Vector2i = path[i] - path[i-1]
		if i == path.size() - 1:
			sprite.texture = arrow_tiles[2]
			if diff_position.x == -1:
				sprite.flip_h = true
			elif diff_position.y == -1:
				sprite.texture = arrow_tiles[3]
			elif diff_position.y == 1:
				sprite.texture = arrow_tiles[3]
				sprite.flip_v = true
		
		if i < path.size() - 1:
			var in_between_diff = path[i+1] - path[i-1]
			#print(in_between_diff)
			if in_between_diff.x != 0 and in_between_diff.y == 0:
				sprite.texture = arrow_tiles[0]
			elif in_between_diff.x == 0 and in_between_diff.y != 0:
				sprite.texture = arrow_tiles[4]
			elif in_between_diff == Vector2i(1,-1):
				sprite.texture = arrow_tiles[1]
			elif in_between_diff == Vector2i(1,1):
				sprite.texture = arrow_tiles[1]
				#sprite.flip_h = true
				sprite.flip_v = true
			elif in_between_diff == Vector2i(-1,-1):
				sprite.texture = arrow_tiles[1]
				sprite.flip_h = true
			elif in_between_diff == Vector2i(-1,1):
				sprite.texture = arrow_tiles[1]
				sprite.flip_h = true
				sprite.flip_v = true
				
		path_sprites.append(sprite)
		add_child(sprite)
	
