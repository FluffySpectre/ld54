class_name FadeIn extends Node2D

@export var fade_in_speed: float = 2.0

var fade_timer: float = 0.0
var do_fade: bool = false

func fade_in():
	do_fade = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if do_fade:
		fade_timer += delta * fade_in_speed
		modulate.a = lerp(0.0, 1.0, fade_timer)
		if (modulate.a >= 1.0):
			do_fade = false
