extends CharacterBody2D

@export var speed: float
@export var dash_speed: float
@export var dash_duration: float
@export var dash_cooldown: float
@export var debug_text_label: RichTextLabel

var move_input_direction: Vector2i = Vector2i.ZERO
var mouse_position: Vector2
var dash_direction: Vector2i
var dash_duration_left: float
var dash_cooldown_left: float


func _ready() -> void:
	dash_direction = Vector2i(0, 1) # arbitrary direction
	dash_duration_left = 0.0
	dash_cooldown_left = 0.0


func _physics_process(delta: float) -> void:
	if dash_duration_left > 0.0:
		velocity = dash_direction * dash_speed
		dash_duration_left -= delta
	else:
		dash_cooldown_left -= delta
		velocity = move_input_direction * speed
	if velocity != Vector2.ZERO:
		move_and_slide()
	look_at(mouse_position)


func _process(_delta: float) -> void:
	# move
	move_input_direction = Vector2i.ZERO
	if Input.is_action_pressed("move_right"):
		move_input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		move_input_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		move_input_direction.y += 1
	if Input.is_action_pressed("move_up"):
		move_input_direction.y -= 1

	# dash
	if move_input_direction != Vector2i.ZERO and dash_duration_left < 0.0:
		dash_direction = move_input_direction
	if Input.is_action_just_pressed("dash") and dash_cooldown_left < 0.0:
		dash_duration_left = dash_duration
		dash_cooldown_left = dash_cooldown

	# look direction
	mouse_position = get_viewport().get_mouse_position()
	debug_text_label.text = "mouse position: %v\n" % mouse_position
	debug_text_label.text += "position: %v\n" % global_position
