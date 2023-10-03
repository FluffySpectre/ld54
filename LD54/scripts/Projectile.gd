class_name Projectile extends Area2D

@export var move_speed = 300
@export var damage: float = 10
@export var visible_notifier: VisibleOnScreenNotifier2D
@export var impact_fx: PackedScene

var target: Vector2

func _ready():
	body_entered.connect(_on_Projectile_body_entered)

func _process(delta):
	if not visible_notifier.is_on_screen():
		destroy_me()

func _physics_process(delta):
	position += transform.x * move_speed * delta

func _on_Projectile_body_entered(body):
	print("Projectile hit: " + body.name)
	#if body.is_in_group("mobs"):
	#	body.queue_free()
	var health = body.get_node("Health")
	if health:
		health.take_damage(damage)
	destroy_me()

func destroy_me():
	if impact_fx:
		var instance = impact_fx.instantiate()
		instance.global_position = get_parent().global_position
		instance.global_rotation = get_parent().global_rotation
		add_child(instance)

	queue_free()
