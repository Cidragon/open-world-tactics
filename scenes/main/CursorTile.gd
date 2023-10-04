extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		position += Vector2(0,-Variables.tile_size)
	elif event.is_action_pressed("ui_right"):
		position += Vector2(Variables.tile_size,0)
	elif event.is_action_pressed("ui_down"):
		position += Vector2(0,Variables.tile_size)
	elif event.is_action_pressed("ui_left"):
		position += Vector2(-Variables.tile_size,0)
