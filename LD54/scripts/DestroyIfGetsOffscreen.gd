class_name DestroyIfGetsOffscreen extends VisibleOnScreenNotifier2D

var was_on_screen = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_on_screen():
		was_on_screen = true
	else:
		if was_on_screen:
			get_parent().queue_free()
		
