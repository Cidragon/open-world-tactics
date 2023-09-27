extends Sprite2D

var pos = Vector2(-8, 9)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_next_frame(animation_name : String, frame_value : int) -> void:
	#print(position.y)
	match frame_value:
		0:
			position.y = pos.y + 1
		1:
			position.y = pos.y
		2:
			position.y = pos.y
		3:
			position.y = pos.y
		4:
			position.y = pos.y + 1

#	match frame:
#		0: position.y = pos.y
#		1: position.y = pos.y - 1

func next_frame() -> void:
	if frame == 0:
		frame = 2
	else:
		frame = 0
	
	print("current_frame: " + str(frame))
