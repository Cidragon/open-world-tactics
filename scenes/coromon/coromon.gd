extends Node2D

@export var animation_sprite_resource : SpriteFrames
@export var walking_speed : float = 0.25
@export var idle_start : String = "idle_left"

@onready var animated_sprite : AnimatedSprite2D = %AnimatedSprite2D
@onready var grass_overlay : Sprite2D = %grass_overlay_creature
@onready var timer : Timer = %Timer
var init_position : Vector2
@export var path : Array[Vector2]
var current_path_index : int = -1
var leaving_grass : bool = false
var counter : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	animated_sprite.sprite_frames = animation_sprite_resource
	init_position = position
	print(init_position)
	print(path)
	animated_sprite.play(idle_start)
	#animated_sprite.connect("change_grass_position", grass_overlay.update_position)
	check_grass_behavior()
	#move_to_next_point()

func _process(_delta: float) -> void:
	#check_grass_behavior()
	pass
	#print(grass_overlay.position)

func move_to_next_point() -> void:
	#print(current_path_index)
	if path.size() and position != init_position + path[current_path_index]:
		var tween = create_tween()
		var next_position = choose_direction(init_position + path[current_path_index])
		animated_sprite.material.set_shader_parameter("side", get_animation_index())
		tween.tween_property(self, "position", next_position, walking_speed)
		
		tween.tween_callback(check_grass_behavior)
		tween.tween_callback(update_path_index)
		tween.tween_callback(move_to_next_point)

func choose_direction(next_position: Vector2) -> Vector2:
	if next_position.x > position.x:
		animated_sprite.play("walk_right")
		return position + Vector2(16,0)
	elif next_position.x < position.x:
		animated_sprite.play("walk_left")
		return position - Vector2(16,0)
	elif next_position.y > position.y:
		animated_sprite.play("walk_down")
		return position + Vector2(0,16)
	elif next_position.y < position.y:
		animated_sprite.play("walk_up")
		return position + Vector2(0,-16)
	return Vector2.ZERO

func is_inside_grass(target_position: Vector2 = position) -> bool:
	var x : int = (int(target_position.x)) + 14
	var y : int = (int(target_position.y)) + 14
	var tile_position : Vector2i = Variables.tilemap.local_to_map(Vector2i(x,y))
	var tile_data = Variables.tilemap.get_cell_tile_data(Variables.GRASS_LAYER,tile_position)
	
	if tile_data != null:
		if tile_data.get_custom_data('is_grass'):
			#print("inside grass")
			return true

	return false

func check_grass_behavior() -> void:
	if is_inside_grass():
		#animated_sprite.material.set_shader_parameter("side", get_animation_index())
		animated_sprite.material.set_shader_parameter("active", true)
		#print(get_animation_index())
		grass_overlay.visible = true
	else:
		#print("shader set to false")
		animated_sprite.material.set_shader_parameter("active", false)
		grass_overlay.visible = false

func update_path_index() -> void:
	if position == init_position + path[current_path_index] and current_path_index < path.size() - 1: 
		timer.start()
		animated_sprite.set_to_idle()
		animated_sprite.material.set_shader_parameter("side", get_animation_index())
	elif position == init_position + path[-1] and current_path_index == path.size() - 1:
		animated_sprite.set_to_idle()
		

func get_animation_index() -> int:
	var animation_name = animated_sprite.get_animation()
	#print(animation_name)
	match animation_name:
		"walk_up": return 0
		"walk_right": return 1
		"walk_down": return 2
		"walk_left": return 3
		"idle_left": return -1
	return -1

func _on_timer_timeout() -> void:
	#print("timer finish")
	timer.stop()
	current_path_index += 1
	move_to_next_point()
	pass # Replace with function body.
