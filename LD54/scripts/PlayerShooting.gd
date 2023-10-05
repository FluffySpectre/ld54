class_name PlayerShooting extends Node

@export var projectile_scene: PackedScene;
@export var parentBody: CharacterBody2D
@export var cooldown = 0.2

var cooldown_timer = 0.0
var shooting_disabled = false

@onready var sound_player: SoundPlayer = get_parent().get_node("SoundPlayer")

func _process(delta):
	if shooting_disabled:
		return
	
	cooldown_timer -= delta
	if Input.is_action_pressed("shoot") and cooldown_timer <= 0:
		shoot()

func shoot():
	var instance = projectile_scene.instantiate()
	instance.global_position = parentBody.global_position
	instance.global_rotation = parentBody.global_rotation + deg_to_rad(-90)
	get_tree().root.add_child(instance)
	
	sound_player.play_sound()
	
	cooldown_timer = cooldown
