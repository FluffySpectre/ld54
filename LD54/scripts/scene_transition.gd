class_name SceneTransition extends CanvasLayer

enum TransitionState {
	None,
	In,
	Out
}

signal transition_finished

var transition_state: TransitionState = TransitionState.None

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.animation_finished.connect(on_animation_finished)

func transition_out():
	animation_player.play("scene_transition_out")
	transition_state = TransitionState.Out
	
func transition_in():
	animation_player.play("scene_transition_in")
	transition_state = TransitionState.In

func is_in_out_transition():
	return transition_state == TransitionState.Out

func is_in_in_transition():
	return transition_state == TransitionState.In

func is_not_in_transition():
	return transition_state == TransitionState.None

func on_animation_finished(_name: String):
	transition_state = TransitionState.None
	transition_finished.emit()
