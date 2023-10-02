class_name Health extends Area2D

@export var max_health: float = 100.0
@export var explosion_scene: PackedScene

var health: float = max_health
var is_dead = false

func _ready():
	self.connect("area_entered", on_hit)

func on_hit(collider):
	print(collider.name)

func take_damage(damage: float):
	health -= damage
	if health < 0:
		health = 0
		if not is_dead:
			is_dead = true
			explode()

func explode():
	if explosion_scene:
		var instance = explosion_scene.instantiate()
		instance.global_position = get_parent().global_position
		instance.global_rotation = get_parent().global_rotation
		add_child(instance)

	get_parent().queue_free()
