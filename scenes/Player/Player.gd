extends CharacterBody2D

const SPEED : float = 75.0

var tilemap : TileMap

@onready var legs : AnimatedSprite2D = %legs
@onready var head : Sprite2D = %head
@onready var shirt_and_pant : AnimatedSprite2D = %"shirt&pant"
@onready var hair : Sprite2D = %hair
@onready var grass_overlay : Sprite2D = %grass_overlay

enum DIRECTIONS { UP,RIGHT,DOWN,LEFT }
var INPUTS = ["ui_up", "ui_right", "ui_down", "ui_left"]
var direction = DIRECTIONS.DOWN
var is_moving : bool = false
var input_press_timer : int = 0
var tile_size : Vector2 = Vector2(16,16)
var direction_history = []
var previous_action = ""

const DATA_LAYER : int = 0
const GRASS_LAYER : int = 2

func _ready() -> void:
	#animation_sprite.material.set_shader_parameter("active", false)
	legs.play(legs.WALK_DOWN)
	legs.connect("frame_information", head.move_to_next_frame)
	legs.connect("frame_information", grass_overlay.move_to_next_frame)


func _process(_delta: float) -> void:
	var last_pressed_action = _controls_loop()
	if previous_action == last_pressed_action:
		input_press_timer += 1
	else:
		previous_action = last_pressed_action
		input_press_timer = 0
	
	if is_moving == false:
		if legs.frame == legs.STAND_FRAME:
			# If player was moving then there is an animation player still running in the background
			#legs.set_frame_and_progress(2,0)
			legs.pause()

	
	if last_pressed_action != "" and input_press_timer == 0 or input_press_timer >= 5:
		handle_inputs(last_pressed_action)
	
	if input_press_timer >= 5:
		input_press_timer = 1
	

func handle_inputs(last_pressed_action : String) -> void:
	if Input.is_action_pressed("ui_up") and last_pressed_action == "ui_up" :
		if direction != DIRECTIONS.UP:
			direction = DIRECTIONS.UP
			legs.play(legs.WALK_UP)
			legs.pause()
			legs.frame = legs.STAND_FRAME
			head.frame = 3
			hair.frame = 3
		else:
			move_to_next_tile(Vector2(0,-tile_size.y))
	elif Input.is_action_pressed("ui_right") and last_pressed_action == "ui_right":
		if direction != DIRECTIONS.RIGHT:
			direction = DIRECTIONS.RIGHT
			legs.play(legs.WALK_RIGHT)
			legs.pause()
			legs.frame = legs.STAND_FRAME
			head.frame = 2
			hair.frame = 2
		else:
			move_to_next_tile(Vector2(tile_size.x,0))
	elif Input.is_action_pressed("ui_down") and last_pressed_action == "ui_down":
		if direction != DIRECTIONS.DOWN:
			direction = DIRECTIONS.DOWN
			legs.play(legs.WALK_DOWN)
			legs.pause()
			legs.frame = legs.STAND_FRAME
			head.frame = 0
			hair.frame = 0
		else:
			move_to_next_tile(Vector2(0,tile_size.y))
	elif Input.is_action_pressed("ui_left") and last_pressed_action == "ui_left":
		if direction != DIRECTIONS.LEFT:
			direction = DIRECTIONS.LEFT
			legs.play(legs.WALK_LEFT)
			legs.pause()
			legs.frame = legs.STAND_FRAME
			head.frame = 1
			hair.frame = 1
		else:
			move_to_next_tile(Vector2(-tile_size.x,0))


func is_inside_grass() -> bool:
	var x : int = (int(position.x)) - 4
	var y : int = (int(position.y)) + 12
	var tile_position : Vector2i = tilemap.local_to_map(Vector2i(x,y))
	var tile_data = tilemap.get_cell_tile_data(GRASS_LAYER,tile_position)
	
	if tile_data != null:
		if tile_data.get_custom_data('is_grass'):
			print("inside grass")
			return true
		else:
			print("nothing here")
			return false
	return false

func is_walkable(next_position : Vector2) -> bool:
	var x : int = (int(next_position.x)) - 4
	var y : int = (int(next_position.y)) + 12
	var tile_position : Vector2i = tilemap.local_to_map(Vector2i(x,y))
	var tile_data = tilemap.get_cell_tile_data(DATA_LAYER,tile_position)
	if tile_data != null:
		if tile_data.get_custom_data('is_tree'):
			print("next tile is a tree")
			print(position)
			print(tilemap.map_to_local(tile_position))
			return false
	return true

func move_to_next_tile(direction : Vector2) -> void:
	if is_moving == false:
		var next_position : Vector2 = position + direction
		if is_walkable(next_position):
			is_moving = true
			var tween = create_tween()
			legs.play()
			tween.tween_property(self,"position", next_position,0.25)
			tween.tween_callback(func(): is_moving = false; print("tween"))
			tween.tween_callback(check_grass_behavior)

func check_grass_behavior() -> void:
	if is_inside_grass():
			legs.material.set_shader_parameter("active", true)
			legs.material.set_shader_parameter("frame", 0)
			shirt_and_pant.material.set_shader_parameter("active", true)
			grass_overlay.visible = true
			grass_overlay.next_frame()
	else:
		legs.material.set_shader_parameter("active", false)
		shirt_and_pant.material.set_shader_parameter("active", false)
		grass_overlay.visible = false

func _controls_loop() -> String:
	for current_direction in INPUTS:
		if Input.is_action_just_released(current_direction):
			var index = direction_history.find(current_direction)
			if index != -1:
				direction_history.remove_at(index)
		if Input.is_action_just_pressed(current_direction):
			direction_history.push_back(current_direction)

	if direction_history.size():
		var current_direction = direction_history[direction_history.size() - 1]
		return current_direction
	return ""
