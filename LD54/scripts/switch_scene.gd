extends Node

@export var scene: Main.GameScene

func switch_scene():
	Main.instance.switch_to_scene(scene)
