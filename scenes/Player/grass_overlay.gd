extends Sprite2D

var initial_pos = Vector2(-8, 9)

func next_frame() -> void:
	if frame == 0:
		frame = 2
	else:
		frame = 0
	
	#print("current_frame: " + str(frame))
