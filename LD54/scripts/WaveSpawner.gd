class_name WaveSpawner extends Area2D

@export var spawn_list: Array[PackedScene]
@export var spawn_delay = 3
@export var num_spawn = 1

var spawn_timer = spawn_delay
var do_spawn = false
var spawned_in_wave = 0

@onready var spawn_area = $CollisionShape2D.shape.extents
@onready var origin = $CollisionShape2D.global_position - spawn_area

func _ready():
	add_to_group("wave_spawners")

func _process(delta):
	if not do_spawn:
		return
	
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn()
		spawn_timer = spawn_delay
		if spawned_in_wave >= num_spawn:
			do_spawn = false

func spawn_wave():
	do_spawn = true
	spawned_in_wave = 0
	spawn_timer = spawn_delay
	print("Start spawning. Num_objects: " + str(num_spawn))
	
func spawn():
	# select a random scene from the spawn list
	var to_spawn = spawn_list[randi() % spawn_list.size()]
	
	var instance = to_spawn.instantiate()
	instance.global_position = global_position
	instance.global_rotation = global_rotation
	get_tree().root.add_child(instance)
	
	spawned_in_wave += 1

func get_random_point_in_spawnarea():
	var x = randf_range(origin.x, spawn_area.x)
	var y = randf_range(origin.y, spawn_area.y)
	return Vector2(x, y)
