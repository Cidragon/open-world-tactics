extends AnimatedSprite2D

signal frame_information(name : String, frame : int)

@onready var shirt_and_pants : AnimatedSprite2D = %"shirt&pant"

const WALK_UP = "walk_up"
const WALK_RIGHT = "walk_right"
const WALK_DOWN = "walk_down"
const WALK_LEFT = "walk_left"
const STAND_FRAME : int = 2

func _on_frame_changed() -> void:
	var current_frame = get_frame()
	if current_frame == 0:
		position.y = 2
		shirt_and_pants.frame = 0
	elif current_frame == 1:
		position.y = 1
		shirt_and_pants.frame = 1
	elif current_frame == 2:
		position.y = 1
		shirt_and_pants.frame = 2
	elif current_frame == 3:
		position.y = 1
		shirt_and_pants.frame = 3
	elif current_frame == 4:
		position.y = 2
		shirt_and_pants.frame = 4
		
	#print("frame position from legs: " + str(position.y))
	frame_information.emit(get_animation(), get_frame())


func _on_animation_changed() -> void:
	var animation_name : String = get_animation()
	match animation_name:
		WALK_UP:
			shirt_and_pants.animation = WALK_UP
		WALK_RIGHT:
			shirt_and_pants.animation = WALK_RIGHT
		WALK_DOWN:
			shirt_and_pants.animation = WALK_DOWN
		WALK_LEFT:
			shirt_and_pants.animation = WALK_LEFT
