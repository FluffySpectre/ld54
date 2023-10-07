class_name PauseGame extends Node

@onready var pause_menu: Panel = $PauseMenuPanel

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	pause_menu.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		pause_menu.visible = get_tree().paused

func continue_game():
	get_tree().paused = false
	pause_menu.visible = false

func quit_game():
	get_tree().quit()
