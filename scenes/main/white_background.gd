extends Sprite2D

var is_active : bool = false
var decreasing : bool = true
var flash_counter : int = 0

func _process(_delta: float) -> void:
	if is_active:
		visible = true
		if decreasing:
			modulate.a -= 0.05
			if modulate.a <= 0:
				decreasing = false
		else:
			modulate.a += 0.05
			if modulate.a >= 1.0:
				flash_counter += 1
				decreasing = true
				if flash_counter >= 1:
					flash_counter = 0
					visible = false
					is_active = false
				
