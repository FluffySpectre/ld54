class_name State extends Node

@export var is_complete: bool

func _ready():
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	pass
	
func enter() -> void:	
	pass
	
func run() -> void:
	pass
	
func exit() -> void:
	pass

func complete() -> void:
	is_complete = true
	pass
