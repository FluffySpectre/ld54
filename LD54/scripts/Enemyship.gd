class_name Enemyship extends CharacterBody2D

@export var stopping_distance = 50

@onready var target_selector: TargetSelector = $TargetSelector
@onready var space_movement: SpaceMovement = $SpaceMovement
@onready var health: Health = $Health
@onready var damage_sound_player: SoundPlayer = $SoundPlayer

func _ready():
	add_to_group("enemies")
	
	health.got_damaged.connect(on_got_damaged)
	
func _process(_delta):
	# retrieve the closest target from the target selector
	var closest_target = target_selector.closest_target

	if closest_target != null:
		var closest_direction = target_selector.closest_target_direction
		var closest_direction_norm = target_selector.closest_target_direction_normalized

		look_at(closest_target.global_position)
		
		# if we are not nearby, move towards the target
		if closest_direction.length() > stopping_distance:
			space_movement.direction = closest_direction_norm
		else:
			space_movement.direction = Vector2.ZERO

func on_got_damaged():
	damage_sound_player.play_sound()
