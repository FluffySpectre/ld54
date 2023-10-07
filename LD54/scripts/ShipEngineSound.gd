class_name ShipEngineSound extends Node

@export var sound: AudioStream

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _process(_delta):
	if Input.is_action_pressed("up"):
		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		if audio_stream_player.playing:
			audio_stream_player.stop()
