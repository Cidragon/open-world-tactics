extends Sprite2D

var start_position : Vector2 = Vector2(8,1)


func update_position(animation_name : String) -> void:
	print(animation_name)
	match animation_name:
		"walk_up": position = start_position
		"walk_right": position = Vector2(4,1)
		"walk_down": position = start_position
		"walk_left": position = start_position 
		"idle_left": position = start_position
