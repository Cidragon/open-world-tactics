extends CharacterBody2D

const SPEED : float = 75.0
@onready var animation_sprite : AnimatedSprite2D = %AnimatedSprite2D

var tilemap : TileMap

@onready var legs : AnimatedSprite2D = %legs
@onready var head : Sprite2D = %head

func _ready() -> void:
	#animation_sprite.material.set_shader_parameter("active", false)
	legs.play("walk_down")
	legs.connect("frame_information", head.move_head)
	pass


func _physics_process(delta: float) -> void:
	is_inside_grass()
	if velocity == Vector2.ZERO:
		# If player was moving then there is an animation player still running in the background
		legs.set_frame_and_progress(2,0)
		legs.pause()
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		legs.play("walk_up")
		head.frame = 3
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		legs.play("walk_right")
		head.frame = 2
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		legs.play("walk_down")
		head.frame = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		legs.play("walk_left")
		head.frame = 1
		

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
