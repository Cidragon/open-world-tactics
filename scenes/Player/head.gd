extends Sprite2D

var init_pos = position

func move_to_next_frame(animation_name : String, frame_value : int) -> void:
	if frame_value in [1,3]:
		position = init_pos
	else:
		position = init_pos + Vector2(0,1)
