extends AnimatedSprite2D

signal frame_information(name : String, frame : int)

@onready var shirt_and_pants : AnimatedSprite2D = %"shirt&pant"

const WALK_UP = "walk_up"
const WALK_RIGHT = "walk_right"
const WALK_DOWN = "walk_down"
const WALK_LEFT = "walk_left"
const STAND_FRAME : int = 2

var init_position = position

func _on_frame_changed() -> void:
	var current_frame = get_frame()
	shirt_and_pants.frame = current_frame
	
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
