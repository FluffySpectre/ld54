class_name SimpleAnimatedSprite extends Sprite2D

@export var fps: float = 2.0
@export var one_shoot = false
@export var one_shot_destroy_after = false

func _process(_delta):
	if one_shoot and frame == hframes - 1:
		if one_shot_destroy_after:
			get_parent().queue_free()
		return
	
	update_frame()

func update_frame():
	var millis = Time.get_ticks_msec()
	var sec = millis / 1000.0
	frame = (int(sec * fps)) % hframes
