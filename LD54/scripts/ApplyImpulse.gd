class_name ApplyImpulse extends RigidBody2D

@export var force_direction: Vector2
@export var torque_force = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	do_force_apply()

func do_force_apply():
	apply_central_impulse(force_direction)
	apply_torque_impulse(torque_force)
