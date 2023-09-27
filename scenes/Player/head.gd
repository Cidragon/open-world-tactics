extends Sprite2D

var init_pos = position

func move_to_next_frame(animation_name : String, frame_value : int) -> void:
	if frame_value % 2 != 0:
		position = init_pos + Vector2(0,1)
	else:
		position = init_pos
