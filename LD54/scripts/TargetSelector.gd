class_name TargetSelector extends Node

@export var target_group: String = "enemy_targets"
@export var max_target_distance = 9999

var closest_target = null
var closest_distance: float = max_target_distance
var closest_target_direction: Vector2
var closest_target_direction_normalized: Vector2
	
func _process(delta):
	# find the nearest target
	var targets = get_tree().get_nodes_in_group(target_group)
	
	# filter dead targets out of the list
	targets = targets.filter(
		func(t):
			var h = t.get_node("Health") as Health
			if h != null:
				return !h.is_dead
			return true
	)
	
	closest_target = null
	closest_distance = max_target_distance

	for target in targets:
		var distance = get_parent().global_position.distance_to(target.global_position)
		if distance < closest_distance:
			closest_target = target
			closest_distance = distance
			
			# calculate direction to target
			closest_target_direction = (closest_target.global_position - get_parent().global_position)
			closest_target_direction_normalized = closest_target_direction.normalized()
