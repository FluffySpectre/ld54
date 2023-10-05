class_name PlayerMovement extends CharacterBody2D

@export var move_speed = 100.0
@export var rotation_speed = 3.0
@export var backward_move_speed = 50.0
@export var flames: Node2D

var rotation_direction: float

func get_input(delta):
	var m_speed = move_speed
	var up_down_input = Input.get_axis("up", "down")
	# slow down, if we go backward
	if up_down_input > 0.0:
		m_speed = backward_move_speed
	
	rotation_direction = Input.get_axis("left", "right")
	velocity += transform.y * up_down_input * m_speed * delta
	
	# add some friction (In space? Ehhm. Ah! There is an automatic system 
	# which uses the front facing thrusters to throttle the spacehip down
	velocity *= 0.95
	
	# show some flames if we move forward
	flames.visible = up_down_input < 0.0

func _physics_process(delta):
	get_input(delta)
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
