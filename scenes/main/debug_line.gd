extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _draw() -> void:
	for i in range(30):
		draw_line(Vector2(i * 64, 0), Vector2(i * 64, 64 * 30),Color.WHITE,2)
		draw_line(Vector2(0, i * 64), Vector2(64 * 30, i * 64),Color.WHITE,2)
		
