class_name Enemyship extends CharacterBody2D

@export var shooting_range = 100
@export var shoot_cooldown = 1.0
@export var stopping_distance = 50

var shoot_timer = 0.0

@onready var target_selector: TargetSelector = get_node("TargetSelector")
@onready var space_movement: SpaceMovement = get_node("SpaceMovement")

func _ready():
	pass  # Hier kannst du anfängliche Einstellungen vornehmen, z.B. den Waffentyp festlegen.

func _process(delta):
	# retrieve the closest target from the target selector
	var closest_target = target_selector.closest_target
	var closest_distance = target_selector.closest_distance
	
	if closest_target:
		# calculate direction to target
		var target_direction = (closest_target.global_position - global_position)
		var target_direction_norm = target_direction.normalized()
		
		look_at(closest_target.global_position)
		
		# if we are out of stopping range, move towards the target
		if target_direction.length() > stopping_distance:
			space_movement.direction = target_direction_norm
		else:
			space_movement.direction = Vector2.ZERO
		
		# check if the target is in shooting range
		if closest_distance <= shooting_range:
			shoot_timer -= delta
			if shoot_timer <= shoot_cooldown:
				shoot(closest_target.global_position)
				shoot_timer = shoot_cooldown

func shoot(target_position):
	# Hier kannst du den Schussvorgang implementieren, z.B. das Erstellen eines Projektils und das Ausrichten auf das Ziel.
	pass
