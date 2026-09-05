extends CharacterBody2D

@export var speed: float = 10.0
var move_input_direction: Vector2i = Vector2i.ZERO
var cursor_position: Vector2

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if move_input_direction != Vector2i.ZERO:
		var move_amount: Vector2 = move_input_direction * speed
		velocity = move_amount
		move_and_slide()


func _process(delta: float) -> void:
	move_input_direction = Vector2i.ZERO
	if Input.is_action_pressed("move_right"):
		move_input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		move_input_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		move_input_direction.y += 1
	if Input.is_action_pressed("move_up"):
		move_input_direction.y -= 1
