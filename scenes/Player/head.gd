extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to_next_frame(animation_name : String, frame_value : int) -> void:
	pass
	#var tween = create_tween()
	if frame_value % 2 != 0:
		position = Vector2(0,1)
		#tween.tween_property(self, "position", Vector2(0,1),0.2)
	else:
		position = Vector2(0,0)
		#tween.tween_property(self, "position", Vector2(0,0),0.2)
		