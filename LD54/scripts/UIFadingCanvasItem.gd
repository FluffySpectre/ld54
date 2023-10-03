class_name UIFadingCanvasItem extends Node

var fade_speed = 1
var target_alpha = 0.0

var fade_out_after = 5.0
var fade_out_timer = fade_out_after

func _process(delta):
	fade_out_timer -= delta
	if fade_out_timer <= 0:
		target_alpha = 0.0
	
	get_parent().modulate.a = lerp(get_parent().modulate.a, target_alpha, delta * fade_speed)
	
func fade_in(fade_out_after_: float):
	target_alpha = 1.0
	fade_out_after = fade_out_after_
	fade_out_timer = fade_out_after
