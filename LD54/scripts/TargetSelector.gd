class_name TargetSelector extends Node

@export var target_group: String = "enemy_targets"
@export var max_target_distance = 300

var closest_target = null
var closest_distance = max_target_distance

func _process(delta):
	# find the nearest target
	var targets = get_tree().get_nodes_in_group(target_group)
	closest_target = null
	closest_distance = max_target_distance

	for target in targets:
		var distance = get_parent().global_position.distance_to(target.global_position)
		if distance < closest_distance:
			closest_target = target
			closest_distance = distance
