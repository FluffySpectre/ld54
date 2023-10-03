class_name GameManager extends Node

signal wave_ended(wave_num: int)

@export var wave_cooldown = 5

var wave_num = 0
var wave_spawners = []
var wave_running = false
var wave_cooldown_timer = wave_cooldown

func _process(delta):
	wave_process(delta)

func wave_process(delta):
	# find all wave spawners in the scene
	if wave_spawners.size() == 0:
		wave_spawners = get_node("WaveSpawners").get_children()
		return
	
	# no wave running? check if we can start a new one
	if !wave_running:
		wave_cooldown_timer -= delta
		if wave_cooldown_timer <= 0:
			start_wave()
			return
			
	if wave_running:
		# no enemies left?
		if not is_wave_running():
			end_wave()

func start_wave():
	wave_running = true
	wave_num += 1
	
	var num_enemies = get_wave_enemy_count() / wave_spawners.size()
	
	var i = 0
	for w in wave_spawners:
		if i < wave_num:
			w.num_spawn = num_enemies
			w.spawn_wave()
		i += 1

func end_wave():
	wave_cooldown_timer = wave_cooldown
	wave_running = false
	
	wave_ended.emit(wave_num)

func get_wave_enemy_count() -> int:
	return wave_spawners.size() * wave_num
	
func is_wave_running():
	for w in wave_spawners:
		if w.do_spawn:
			return true
	return get_tree().get_nodes_in_group("enemies").size() > 0
