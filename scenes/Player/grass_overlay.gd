extends Sprite2D

var initial_pos = Vector2(-8, 9)

func move_to_next_frame(_animation_name : String, frame_value : int) -> void:
	#print(position.y)
	match frame_value:
		0:
			position.y = initial_pos.y + 1
		1:
			position.y = initial_pos.y
		2:
			position.y = initial_pos.y
		3:
			position.y = initial_pos.y
		4:
			position.y = initial_pos.y + 1

func next_frame() -> void:
	if frame == 0:
		frame = 2
	else:
		frame = 0
	
	#print("current_frame: " + str(frame))
