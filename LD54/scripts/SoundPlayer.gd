class_name SoundPlayer extends Node

@export var sounds: Array[AudioStream] = []
@export var autoplay = false
@export var randomize_pitch = false
@export var min_pitch_offset = -0.1
@export var max_pitch_offset = 0.1

func _ready():
	if autoplay:
		play_sound()

func play_sound():
	if sounds.is_empty():
		return
	var sfx = sounds[randi() % sounds.size()]
	var pitch = 1.0
	if randomize_pitch:
		pitch = 1.0 + randf_range(min_pitch_offset, max_pitch_offset)
	SoundManager.instance.play(sfx, pitch)

