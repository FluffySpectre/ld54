class_name Main extends Node2D

enum GameScene {
	Menu,
	Game,
}

@export var scenes: Array[PackedScene]

static var instance: Main
var game_scene: GameScene
var scene_container: Node
var scene_switch_state: int = -1
var no_transition: bool = false

@onready var scene_transition: SceneTransition = $SceneTransitionCanvasLayer

func _ready():
	instance = self
	
	switch_to_scene(GameScene.Menu, true)

func _process(_delta):
	if scene_switch_state >= 0 and not no_transition:
		if scene_switch_state == 0 and scene_transition.is_not_in_transition() and game_scene < scenes.size():
			# run out transition
			scene_transition.transition_out()
			scene_switch_state = 1
			return
		
		# the stage is hidden, so do all the stuff we have to do
		if scene_switch_state == 1 and not scene_transition.is_in_out_transition():
			do_scene_switch()
			
			# transition back in
			scene_switch_state = -1
			scene_transition.transition_in()
	
	if scene_switch_state >= 0 and no_transition:
		do_scene_switch()
		scene_switch_state = -1

func switch_to_scene(scene: GameScene, no_transition_: bool = false):
	game_scene = scene
	
	scene_switch_state = 0
	no_transition = no_transition_

func do_scene_switch():
	# clear up active scene first
	if scene_container != null and scene_container.get_child_count() > 0:
		scene_container.queue_free()
	
	# create a fresh container for the new scene objects
	scene_container = Node.new()
	
	# instantiate the new scene and add it to the
	# scene container
	var scene_instance = scenes[game_scene].instantiate()
	scene_container.add_child(scene_instance)
	
	# add the scene container to the main scene
	add_child(scene_container)

func get_scene_root() -> Node:
	return scene_container.get_child(0)
