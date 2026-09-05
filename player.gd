extends CharacterBody2D

@export var speed: float = 10.0
@export var debug_text_label: RichTextLabel

var move_input_direction: Vector2i = Vector2i.ZERO
var mouse_position: Vector2


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if move_input_direction != Vector2i.ZERO:
		var move_amount: Vector2 = move_input_direction * speed
		velocity = move_amount
		move_and_slide()
	look_at(mouse_position)


func _process(_delta: float) -> void:
	move_input_direction = Vector2i.ZERO
	if Input.is_action_pressed("move_right"):
		move_input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		move_input_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		move_input_direction.y += 1
	if Input.is_action_pressed("move_up"):
		move_input_direction.y -= 1
	mouse_position = get_viewport().get_mouse_position()
	debug_text_label.text = "mouse position: %v\n" % mouse_position
	debug_text_label.text += "position: %v\n" % global_position


func _input(event: InputEvent) -> void:
	pass
