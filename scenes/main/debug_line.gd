extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _draw() -> void:
	for i in range(30):
		var some_white = Color.WHITE
		some_white.a = 0.5
		draw_line(Vector2(i * 64, 0), Vector2(i * 64, 64 * 30),some_white,2)
		draw_line(Vector2(0, i * 64), Vector2(64 * 30, i * 64),some_white,2)
		
