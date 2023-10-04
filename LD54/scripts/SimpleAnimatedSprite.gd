class_name SimpleAnimatedSprite extends Sprite2D

@export var fps: float = 2.0

func _process(delta):
	update_frame()

func update_frame():
	var millis = Time.get_ticks_msec()
	var sec = millis / 1000.0
	frame = (int(sec * fps)) % hframes
