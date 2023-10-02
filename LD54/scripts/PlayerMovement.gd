class_name PlayerMovement extends CharacterBody2D

@export var move_speed = 100.0
@export var rotation_speed = 3.0

var rotation_direction: float

func get_input(delta):
	rotation_direction = Input.get_axis("left", "right")
	velocity += transform.y * Input.get_axis("up", "down") * move_speed * delta
	velocity *= 0.95

func _physics_process(delta):
	get_input(delta)
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
