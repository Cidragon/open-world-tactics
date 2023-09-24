extends CharacterBody2D

const SPEED : float = 100.0
enum DIRECTIONS{
	UP,
	RIGHT,
	DOWN,
	LEFT
}
@onready var animation_sprite : AnimatedSprite2D = %AnimatedSprite2D

var current_direction = DIRECTIONS.DOWN

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		animation_sprite.play("idle")
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -SPEED
		animation_sprite.play("walk_up")
		current_direction = DIRECTIONS.UP
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		animation_sprite.play("walk_right")
		current_direction = DIRECTIONS.RIGHT
	elif Input.is_action_pressed("ui_down"):
		velocity.y = SPEED
		animation_sprite.play("walk_down")
		current_direction = DIRECTIONS.DOWN
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		animation_sprite.play("walk_left")
		current_direction = DIRECTIONS.LEFT

	move_and_slide()
