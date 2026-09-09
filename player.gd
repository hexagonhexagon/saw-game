extends CharacterBody2D

@export var speed: float
@export var dash_speed: float
@export var dash_duration: float
@export var dash_cooldown: float

@export var dash_shadow: PackedScene
@export var num_dash_shadows: int

@export var debug_text_label: RichTextLabel

var move_input_direction: Vector2 = Vector2.ZERO
var mouse_position: Vector2
var dash_direction: Vector2
var dash_duration_left: float
var dash_shadow_cooldown: float
var dash_shadow_cooldown_left: float
var dash_cooldown_left: float

@onready var PlayerShape := %PlayerShape


func _ready() -> void:
	dash_direction = Vector2(0, 1) # arbitrary direction
	dash_duration_left = 0.0
	dash_cooldown_left = 0.0
	dash_shadow_cooldown = dash_cooldown / (num_dash_shadows + 1)
	dash_shadow_cooldown_left = 0.0


func _physics_process(delta: float) -> void:
	if dash_duration_left > 0.0:
		velocity = dash_direction * dash_speed
		dash_duration_left -= delta
		dash_shadow_cooldown_left -= delta
		if dash_shadow_cooldown_left < 0.0:
			var new_dash_shadow: Node = dash_shadow.instantiate()
			new_dash_shadow.transform = transform
			new_dash_shadow.scale = PlayerShape.scale
			dash_shadow_cooldown_left = dash_shadow_cooldown
			get_parent().add_child(new_dash_shadow)
	else:
		dash_cooldown_left -= delta
		velocity = move_input_direction * speed
	if velocity != Vector2.ZERO:
		move_and_slide()
	look_at(mouse_position)


func _process(_delta: float) -> void:
	# move
	move_input_direction = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		move_input_direction.x += 1
	if Input.is_action_pressed("move_left"):
		move_input_direction.x -= 1
	if Input.is_action_pressed("move_down"):
		move_input_direction.y += 1
	if Input.is_action_pressed("move_up"):
		move_input_direction.y -= 1
	move_input_direction = move_input_direction.normalized()

	# dash
	if move_input_direction != Vector2.ZERO and dash_duration_left < 0.0:
		dash_direction = move_input_direction
	if Input.is_action_just_pressed("dash") and dash_cooldown_left < 0.0:
		dash_duration_left = dash_duration
		dash_shadow_cooldown_left = dash_shadow_cooldown
		dash_cooldown_left = dash_cooldown

	# look direction
	mouse_position = get_viewport().get_mouse_position()
	debug_text_label.text = "mouse position: %v\n" % mouse_position
	debug_text_label.text += "position: %v\n" % global_position
