extends AnimatedSprite2D

signal frame_information(name : String, frame : int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_frame_changed() -> void:
	var current_frame = get_frame()
	if current_frame == 0:
		position.y = 2
	elif current_frame == 1:
		position.y = 1
	elif current_frame == 2:
		position.y = 1
	elif current_frame == 3:
		position.y = 1
	elif current_frame == 4:
		position.y = 2
		

	frame_information.emit(get_animation(), get_frame())
