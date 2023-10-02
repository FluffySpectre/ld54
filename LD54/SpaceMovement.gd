class_name SpaceMovement extends Node

@export var accel_speed = 30.0
@export var direction: Vector2 = Vector2.ZERO
@export var friction_mult = 0.95

var parentBody: CharacterBody2D

func _ready():
	parentBody = get_parent() as CharacterBody2D
	
func _physics_process(delta):
	parentBody.velocity += parentBody.transform.y * direction * accel_speed * delta
	parentBody.velocity *= friction_mult
	parentBody.move_and_slide()
