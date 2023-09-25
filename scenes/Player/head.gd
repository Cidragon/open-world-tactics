extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_head(animation_name : String, frame_value : int) -> void:
	pass
	if frame_value % 2 != 0:
		offset = Vector2(0,1)
	else:
		offset = Vector2(0,0)
