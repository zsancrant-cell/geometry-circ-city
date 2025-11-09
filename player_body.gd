extends CharacterBody2D

@export var speed: float = 125.0
@export var acceleration: float = 10.0
@export var friction: float = 15.0
@export var rotation_speed: float = 3.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var movement_particles: CPUParticles2D = $CPUParticles2D
@onready var headlights: PointLight2D = $PointLight2D

var angular_velocity: float = 0.0
var headlights_on: bool = true

func _ready() -> void:
	if headlights:
		headlights.enabled = headlights_on

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("headlights"):
		headlights_on = not headlights_on
		if headlights:
			headlights.enabled = headlights_on
			
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
	
	if movement_particles:
		movement_particles.emitting = (input_direction != Vector2.ZERO)
	
	var rotation_direction: float = 0.0
	if Input.is_action_pressed("move_right"):
		rotation_direction = 1.0
	elif Input.is_action_pressed("move_left"):
		rotation_direction = -1.0
	
	var target_angular_velocity: float = rotation_direction * rotation_speed
	
	if rotation_direction != 0.0:
		angular_velocity = lerp(angular_velocity, target_angular_velocity, acceleration * delta)
	else:
		angular_velocity = lerp(angular_velocity, 0.0, friction * delta)
	
	rotation += angular_velocity * delta
	
	move_and_slide()
