extends TileMap

const water_source : int = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func pause_animation() -> void:
	var tile_set_atlas_source : TileSetSource = tile_set.get_source(water_source)
	for i in range(0, tile_set_atlas_source.get_tiles_count()):
		var atlas_coordinates : Vector2i = tile_set_atlas_source.get_tile_id(i)
		var frame_count : int = tile_set_atlas_source.get_tile_animation_frames_count(atlas_coordinates)
		if frame_count > 1:
			tile_set_atlas_source.set_tile_animation_frame_duration(atlas_coordinates, water_source, INF)
