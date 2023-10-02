class_name Enemyship extends CharacterBody2D

@export var stopping_distance = 50

@onready var target_selector: TargetSelector = get_node("TargetSelector")
@onready var space_movement: SpaceMovement = get_node("SpaceMovement")

func _ready():
	pass  # Hier kannst du anfängliche Einstellungen vornehmen, z.B. den Waffentyp festlegen.

func _process(delta):
	# retrieve the closest target from the target selector
	var closest_target = target_selector.closest_target

	if closest_target:
		var closest_distance = target_selector.closest_distance
		var closest_direction = target_selector.closest_target_direction
		var closest_direction_norm = target_selector.closest_target_direction_normalized
		
		look_at(closest_target.global_position)
		
		# if we are not nearby, move towards the target
		if closest_direction.length() > stopping_distance:
			space_movement.direction = closest_direction_norm
		else:
			space_movement.direction = Vector2.ZERO
