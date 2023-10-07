class_name WaveSpawner extends Area2D

@export var spawn_list: Array[PackedScene]
@export var spawn_delay = 3
@export var num_spawn = 1

var spawn_timer = spawn_delay
var do_spawn = false
var spawned_in_wave = 0
var rng = RandomNumberGenerator.new()

# @onready var spawn_radius = $CollisionShape2D.shape.radius
@onready var spawn_area = $CollisionShape2D.shape.get_rect()

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
	instance.global_position = get_random_point_in_spawnarea()
	instance.global_rotation = global_rotation
	Main.instance.get_scene_root().add_child(instance)
	
	spawned_in_wave += 1

func get_random_point_in_spawnarea():
	#var x = global_position.x + rng.randf_range(-spawn_radius, spawn_radius)
	#var y = global_position.y + rng.randf_range(-spawn_radius, spawn_radius)
	var x = global_position.x + rng.randf_range(0, spawn_area.size.x)
	var y = global_position.y + rng.randf_range(0, spawn_area.size.y)
	return Vector2(x, y)
