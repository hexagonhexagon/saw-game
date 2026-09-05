extends Polygon2D

@export var start_opacity: float
@export var fade_out_duration: float

func _ready() -> void:
	color.a = start_opacity

func _process(delta: float) -> void:
	var decay_amount: float = delta * start_opacity / fade_out_duration
	color.a = clampf(color.a - decay_amount, 0.0, start_opacity)
	if color.a == 0.0:
		queue_free()
