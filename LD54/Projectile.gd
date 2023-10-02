class_name Projectile extends CharacterBody2D

@export var move_speed = 300
@export var visible_notifier: VisibleOnScreenNotifier2D

var target: Vector2

func _process(delta):
	if not visible_notifier.is_on_screen():
		destroy_me()

func _physics_process(delta):
	#look_at(target)
	velocity = transform.x * move_speed
	move_and_slide()

func destroy_me():
	print("Projectile destroyed!")
	queue_free()
