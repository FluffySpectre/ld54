class_name Generator extends RigidBody2D

@export var ring_sprite: Sprite2D
@export var ring_colors = [Color(235.0 / 255.0, 25.0 / 255.0, 25.0 / 255.0), Color(251.0 / 255.0, 242.0 / 255.0, 54.0 / 255.0), Color(153.0 / 255.0, 229.0 / 255.0, 80.0 / 255.0)]

@onready var health: Health = get_node("Health")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var healthPercent = health.health / health.max_health
	change_ring_color(healthPercent)
	
func change_ring_color(factor: float):
	var current_color = ring_colors[0].lerp(ring_colors[1], factor)
	if factor >= 0.5:
		current_color = ring_colors[1].lerp(ring_colors[2], (factor - 0.5) * 2)
	ring_sprite.modulate = current_color
