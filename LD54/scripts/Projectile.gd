class_name Projectile extends CharacterBody2D

@export var move_speed = 300
@export var visible_notifier: VisibleOnScreenNotifier2D
@export var impact_scene: PackedScene

var target: Vector2

func _process(delta):
	if not visible_notifier.is_on_screen():
		destroy_me()

func _physics_process(delta):
	#look_at(target)
	velocity = transform.x * move_speed
	move_and_slide()
	check_collisions()

func check_collisions():
	if get_slide_collision_count() > 0:
		destroy_me()

func destroy_me():
	print("Projectile destroyed!")
	if impact_scene:
		var instance = impact_scene.instantiate()
		instance.global_position = get_parent().global_position
		instance.global_rotation = get_parent().global_rotation
		add_child(instance)

	queue_free()
