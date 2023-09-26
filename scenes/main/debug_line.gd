extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _draw() -> void:
	for i in range(20):
		draw_line(Vector2(i * 64, 0), Vector2(i * 64, 64 * 20),Color.WHITE,2)
		draw_line(Vector2(0, i * 64), Vector2(64 * 20, i * 64),Color.WHITE,2)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
