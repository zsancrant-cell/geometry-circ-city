extends CharacterBody2D

@export var speed: float = 125.0
@export var acceleration: float = 10.0
@export var friction: float = 15.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite


func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		input_direction = transform.x
	elif Input.is_action_pressed("move_down"):
		input_direction = -transform.x
		
	var target_velocity: Vector2 = input_direction * speed
	
	if input_direction != Vector2.ZERO:
		velocity = velocity.lerp(target_velocity, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
	look_at(get_global_mouse_position())
