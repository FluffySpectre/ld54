class_name DestroyAfterTime extends Node

@export var delay: float = 1.0
@export var destroy_parent = true

var destroy_timer = 0.0

func _process(delta):
	destroy_timer += delta
	if destroy_timer >= delay:
		if destroy_parent:
			get_parent().queue_free()
		else:
			queue_free()
