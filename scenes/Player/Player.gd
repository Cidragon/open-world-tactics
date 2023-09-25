extends CharacterBody2D

const SPEED : float = 75.0
@onready var animation_sprite : AnimatedSprite2D = %AnimatedSprite2D

var tilemap : TileMap

func _ready() -> void:
	#animation_sprite.material.set_shader_parameter("active", false)
	pass


func _physics_process(delta: float) -> void:
	is_inside_grass()
	if velocity == Vector2.ZERO:
		# If player was moving then there is an animation player still running in the background
		animation_sprite.set_frame_and_progress(0,0)
		animation_sprite.pause()
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		animation_sprite.play("walk_up")
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		animation_sprite.play("walk_right")
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		animation_sprite.play("walk_down")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		animation_sprite.play("walk_left")

	move_and_slide()

func is_inside_grass() -> bool:
	var x : int = (int(position.x)) + 8
	var y : int = (int(position.y)) + 28
	var tile_position : Vector2i = tilemap.local_to_map(Vector2i(x,y))
	#print(str(position.x) + " " + str(position.y))
	#print(tile_position)
	var tile_data = tilemap.get_cell_tile_data(1,tile_position)
	if tile_data != null:
		if tile_data.get_custom_data('is_grass'):
			print("inside grass")
			animation_sprite.material.set_shader_parameter("active", true)
		else:
			animation_sprite.material.set_shader_parameter("active", false)
	else:
		animation_sprite.material.set_shader_parameter("active", false)
		
		#print("asd")
	return false
