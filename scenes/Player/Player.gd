extends CharacterBody2D

const SPEED : float = 100.0
@onready var animation_sprite : AnimatedSprite2D = %AnimatedSprite2D


func _physics_process(delta: float) -> void:
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

