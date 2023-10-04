class_name Shooting extends Node

@export var projectile_scene: PackedScene
@export var shooting_range = 100
@export var shoot_cooldown = 1.0
@export var parentBody: CharacterBody2D
@export var target_selector: TargetSelector

var shoot_timer = shoot_cooldown

func _process(delta):
	# retrieve the closest target from the target selector
	var closest_target = target_selector.closest_target
	
	if closest_target:
		var closest_distance = target_selector.closest_distance
		
		# check if the target is in shooting range
		if closest_distance <= shooting_range:
			shoot_timer -= delta
			if shoot_timer <= 0:
				shoot(closest_target.global_position)
				shoot_timer = shoot_cooldown

func shoot(_target_position):
	var instance = projectile_scene.instantiate()
	instance.global_position = parentBody.global_position
	instance.global_rotation = parentBody.global_rotation
	add_child(instance)
