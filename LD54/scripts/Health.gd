class_name Health extends Node

signal died

@export var max_health: float = 100.0
@export var explosion_scene: PackedScene
@export var dont_destroy_on_death: bool = false

@onready var health: float = max_health
var is_dead = false

func take_damage(damage: float):
	#print(get_parent().name + " took " + str(damage) + " damage (max_health=" + str(max_health) + ")")
	
	health -= damage
	if health <= 0:
		health = 0
		if not is_dead:
			is_dead = true
			explode()
			died.emit()

func explode():
	if explosion_scene:
		var instance = explosion_scene.instantiate()
		instance.global_position = get_parent().global_position
		instance.global_rotation = get_parent().global_rotation
		add_child(instance)
	
	if not dont_destroy_on_death:
		get_parent().queue_free()
		print(get_parent().name + " destroyed!")
