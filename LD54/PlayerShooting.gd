class_name PlayerShooting extends Node

@export var projectile_scene: PackedScene;
@export var parentBody: CharacterBody2D
@export var cooldown = 0.2

var cooldown_timer = 0.0

func _process(delta):
	cooldown_timer -= delta
	if Input.is_action_pressed("shoot") and cooldown_timer <= 0:
		shoot()

func _physics_process(delta):
	pass

func shoot():
	var instance = projectile_scene.instantiate()
	instance.global_position = parentBody.global_position
	instance.global_rotation = parentBody.global_rotation + deg_to_rad(-90)

	add_child(instance)
	cooldown_timer = cooldown
