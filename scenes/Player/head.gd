extends Sprite2D

func move_to_next_frame(animation_name : String, frame_value : int) -> void:
	if frame_value % 2 != 0:
		position = Vector2(0,1)
	else:
		position = Vector2(0,0)
